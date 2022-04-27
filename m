Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B205112C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359024AbiD0HsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359023AbiD0Hrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:47:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D391594A6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4F30B82522
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C78C385A9;
        Wed, 27 Apr 2022 07:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651045480;
        bh=I18bs66G2uf5DPVlbIEaZXD74gjZ9PfE8Eqt8iUP8H0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=behZyIvQY9Orw+SuOUoSnrENbyYurLUx8yzQRGdfUiL6S7YhOL5uQAdTr2+F3TqIq
         0W+NlnK7tVCl8dWx0oXmNt2qPTjS3G5sgjQYfg2C01dccSf1vkUUZ/3xoXa9ahR+9b
         MV3r/CbO5C45QHgMfy/7OeDmyh3NjOzHQPz9eDvU=
Date:   Wed, 27 Apr 2022 09:44:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com
Subject: Re: [PATCH v3] arch_topology: Trace the update thermal pressure
Message-ID: <Ymj0ZZeUnhq4W/Ws@kroah.com>
References: <20220427073551.19032-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427073551.19032-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:35:51AM +0100, Lukasz Luba wrote:
> Add trace event to capture the moment of the call for updating the thermal
> pressure value. It's helpful to investigate how often those events occur
> in a system dealing with throttling. This trace event is needed since the
> old 'cdev_update' might not be used by some drivers.
> 
> The old 'cdev_update' trace event only provides a cooling state
> value: [0, n]. That state value then needs additional tools to translate
> it: state -> freq -> capacity -> thermal pressure. This new trace event
> just stores proper thermal pressure value in the trace buffer, no need
> for additional logic. This is helpful for cooperation when someone can
> simply sends to the list the trace buffer output from the platform (no
> need from additional information from other subsystems).
> 
> There are also platforms which due to some design reasons don't use
> cooling devices and thus don't trigger old 'cdev_update' trace event.
> They are also important and measuring latency for the thermal signal
> raising/decaying characteristics is in scope. This new trace event
> would cover them as well.
> 
> We already have a trace point 'pelt_thermal_tp' which after a change to
> trace event can be paired with this new 'thermal_pressure_update' and
> derive more insight what is going on in the system under thermal pressure
> (and why).
> 
> Reported-by: kernel test robot <lkp@intel.com>

The kernel test robot did not report that you needed to add a new trace
event :(

