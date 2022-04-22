Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733F850BB8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449377AbiDVPU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449390AbiDVPUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:20:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E6F5DA37;
        Fri, 22 Apr 2022 08:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66C26B830EE;
        Fri, 22 Apr 2022 15:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A523BC385A0;
        Fri, 22 Apr 2022 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650640671;
        bh=OQu2HnPIYsfQw0YtgkB3j0oCb5sAGQ5oTcK00sCNEoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ziLUmyry5BXoBF9rZ5VdG5+lvPTU7ab5iiUsLrmyA/DfjkCh/W3oZv/EPJQTm2bSp
         x7937822JWbxTjtKGf/0GvPPWve40RfNLMDLl/deXWMwUbxprutwKZAsx/1HzJ1WHB
         xbCMyZG6JVxLqWl47+Nfiob9MOHr7SO/pLVBZbhw=
Date:   Fri, 22 Apr 2022 17:17:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yizhuo Zhai <yzhai003@ucr.edu>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Fix some race conditions that exists between
 fbmem and sysfb
Message-ID: <YmLHHCQyN03oAqr0@kroah.com>
References: <20220420085303.100654-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420085303.100654-1-javierm@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:52:58AM +0200, Javier Martinez Canillas wrote:
> Hello,
> 
> The patches in this series are mostly changes suggested by Daniel Vetter
> to fix some race conditions that exists between the fbdev core (fbmem)
> and sysfb with regard to device registration and removal.
> 
> For example, it is currently possible for sysfb to register a platform
> device after a real DRM driver was registered and requested to remove the
> conflicting framebuffers.
> 
> A symptom of this issue, was worked around with by commit fb561bf9abde
> ("fbdev: Prevent probing generic drivers if a FB is already registered")
> but that's really a hack and should be reverted.
> 
> This series attempt to fix it more properly and revert the mentioned hack.
> That will also unblock a pending patch to not make the num_registered_fb
> variable visible to drivers anymore, since that's internal to fbdev core.
> 
> Patch #1 is just a trivial preparatory change.
> 
> Patch #2 add sysfb_disable() and sysfb_try_unregister() helpers for fbmem
> to use them.
> 
> Patch #3 changes how is dealt with conflicting framebuffers unregistering,
> rather than having a variable to determine if a lock should be take, it
> just drops the lock before unregistering the platform device.
> 
> Patch #4 fixes the mentioned race conditions and finally patch #5 is the
> revert patch that was posted by Daniel before but he dropped from his set.
> 
> The patches were tested on a rpi4 using different video configurations:
> (simpledrm -> vc4 both builtin, only vc4 builtin, only simpledrm builtin
> and simpledrm builtin with vc4 built as a module).
> 
> Best regards,
> Javier

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
