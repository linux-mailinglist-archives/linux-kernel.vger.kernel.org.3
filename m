Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3B50E2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbiDYOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbiDYOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010D42B2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C7A261617
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74050C385A4;
        Mon, 25 Apr 2022 14:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650895975;
        bh=zwEMKKSkDVg1tfC/+WJoLnkuTK+9wkmEjucI25mBn7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGEl5W2/nZGZWL4S4BkS/ZoUUxYAbtgvtmsESawFfdj4Y4ItJPfVKsqu4ZFO0XXDF
         i3P9jgAUiqatbFNk0UuVjvliP9mKIHYML1qRWYR9yMU6LItF2lkjCWwMua5s3PccaT
         Ce919vbldSFQOhcitN0EWBluijCO5iNqInzfExIg=
Date:   Mon, 25 Apr 2022 16:12:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com
Subject: Re: [PATCH v2] arch_topology: Trace the update thermal pressure
Message-ID: <YmasYv5xHH7EbXXn@kroah.com>
References: <20220425135317.5880-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425135317.5880-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 02:53:17PM +0100, Lukasz Luba wrote:
> Add trace event to capture the moment of the call for updating the thermal
> pressure value. It's helpful to investigate how often those events occurs
> in a system dealing with throttling. This trace event is needed since the
> old 'cdev_update' might not be used by some drivers. Also, the new trace
> event shows capacity value, not a cooling state.

Wait, why are thermal events not going through the thermal system so
that thermal_cdev_update() would catch them?  Don't work around broken
systems, force them to use the correct apis.

thanks,

greg k-h
