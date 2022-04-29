Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0929514EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377967AbiD2PFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377483AbiD2PFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:05:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2691CCD67E;
        Fri, 29 Apr 2022 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FWCGga2NwFtl2WJVRbR0+x5nY0E6GFEiFEIQiEh0aDI=; b=nd0C0YhSkMyx/VBQxvNGDviF35
        b4hcz/MDiayfv5OMOwHlMLqrdxLyiopVPrSBCUV3hcRluZw2OXonnN/JE7Xec2kXWDlJJKfxpE5Vr
        JY6z1zQFxlB9DeUZB7BShcOFFqfzvowQiekvk8OGmTXQZLSrl4uOQbIwfwZcABkvc0Jd3yneVopit
        jVz9FcQM+iPF1WUBDfQFMSdkt0Nr1Bf2a/4fdSmkCrbZ5Ic9zy84ZNxcGXqPwpIpIhdtnb936B410
        cI2AJ/uPCj1pCUrbDhnJFi18oyOScAjfpoLCGyep1fytQ5prukL7IiVtTC5Lx0xrSL+ozLQOceWa9
        6wHE0rkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkS8H-00BhoU-W1; Fri, 29 Apr 2022 15:02:10 +0000
Date:   Fri, 29 Apr 2022 08:02:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Changcheng Deng <deng.changcheng@zte.com.cn>
Subject: Re: [RFC PATCH v4 11/11] fbdev: Make registered_fb[] private to
 fbmem.c
Message-ID: <Ymv98Y85rW/2r9m8@infradead.org>
References: <20220429084253.1085911-1-javierm@redhat.com>
 <20220429084253.1085911-12-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429084253.1085911-12-javierm@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:42:53AM +0200, Javier Martinez Canillas wrote:
> From: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Well except when the olpc dcon fbdev driver is enabled, that thing
> digs around in there in rather unfixable ways.
> 
> Cc oldc_dcon maintainers as fyi.
> 
> v2: I typoed the config name (0day)

We should not keep broken code and/or core code ifdefs around for
staging drivers.  Just disable the driver if it is in such a bad
state.
