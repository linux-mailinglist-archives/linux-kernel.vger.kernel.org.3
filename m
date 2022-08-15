Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FD25932B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiHOQCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiHOQCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FB1312755
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660579332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRewpnKaRuVPd5sJzyIXphPbC3RcQL3QuITGgVWbi+A=;
        b=VZ2Jgc3+fPAOYvI83MB/sYoOC9OkgMRf4qqIZWC+2Fn7fFmzU2ZtZSj5A1+SWmuWUiJgzD
        GSfNJNGPatYEFhBd8tKIs+b5pwEW/swSDMkeVSd7IDxwmgMMWxj53ueGq8OOvvILwuMo2/
        8LIxFq7lcNCSYUqsEpRX5/2DSQougT8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-X4JKv1rwMiSGep7yubROjg-1; Mon, 15 Aug 2022 12:02:02 -0400
X-MC-Unique: X4JKv1rwMiSGep7yubROjg-1
Received: by mail-ej1-f69.google.com with SMTP id ne41-20020a1709077ba900b00730cde40757so1187744ejc.23
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IRewpnKaRuVPd5sJzyIXphPbC3RcQL3QuITGgVWbi+A=;
        b=7gKMqCoUWA4mcPs4Lg5EGGDJMjG2QBEPRbRRRJ+nOVWNa5xAfikWKV4fw1/JZvKBsP
         VqNcRfcaAmH4BImOAJvyd2knF8JmjxVfXOMbcW7SK1XpFrfttB7zm240r2BqOtpAwY35
         bPKc1G25b5BzYvsSo3yBlZvaIsla4CmSjvI0ztP/AtTXG3BPRkMf962LJZZ9hEehxMFS
         thUEw3cDgiRkTxCOY0C9YGTzsOLq7X+X+nDNyxUY3Y2iexZlIwnMyVsjf88sOzgqpNE7
         kORRSMfc4vDiUQ3Hmhr1IpPUv3NKhwQHCm7a+hsjxdHr/Rsdbwc9qTnbk9Ou8indBb9r
         XraA==
X-Gm-Message-State: ACgBeo1ocqoi4pCVATy6UII4dxntyiuacb5fCeuYFLMHv+BXnkqEMIvR
        AdHe+G4gEDpuxqGyTZl0j5ik7uWPWnOMk/jzm2YAa3gA0ImR6d5gSMaMdOKLGJWjZ8zM7uKHc5S
        0wnMSwO/Jni1GZvuq/N/ibLcF
X-Received: by 2002:a17:906:84e1:b0:732:1ea0:8b43 with SMTP id zp1-20020a17090684e100b007321ea08b43mr10934696ejb.343.1660579321256;
        Mon, 15 Aug 2022 09:02:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7RbQS7SJTVfwBAvZ3dcWAMwAj5XR1sOAxuUAtfXBczQCdaVsAq/CHoIhlsRUCmNNSm8KHJRQ==
X-Received: by 2002:a17:906:84e1:b0:732:1ea0:8b43 with SMTP id zp1-20020a17090684e100b007321ea08b43mr10934692ejb.343.1660579321075;
        Mon, 15 Aug 2022 09:02:01 -0700 (PDT)
Received: from redhat.com ([2.54.169.49])
        by smtp.gmail.com with ESMTPSA id ch15-20020a0564021bcf00b00440a1888e00sm6839816edb.59.2022.08.15.09.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:02:00 -0700 (PDT)
Date:   Mon, 15 Aug 2022 12:01:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815120007-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net>
 <20220815054117-mutt-send-email-mst@kernel.org>
 <20220815154920.GA4027315@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815154920.GA4027315@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 08:49:20AM -0700, Guenter Roeck wrote:
> On Mon, Aug 15, 2022 at 05:43:19AM -0400, Michael S. Tsirkin wrote:
> > On Sun, Aug 14, 2022 at 02:26:10PM -0700, Guenter Roeck wrote:
> > > Hi all,
> > > 
> > > syscaller reports lots of crashes with the mainline kernel. The latest
> > > I have seen, based on the current ToT, is attached. Backtraces are not
> > > always the same, but this one is typical.
> > > 
> > > I have not tried to analyze this further.
> > > 
> > > Guenter
> > 
> > Thanks a lot for the report!
> > 
> > Could you please try the latest vhost tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> > 
> > which has been reported by Andres Freund to fix a similar issue?
> > 
> 
> I have now literally seen dozens of reports with syzcaller crashing
> in various code locations, but we are still trying to actually reproduce
> the problem. We'll respond on the revert patch once we can reproduce the
> issue and thus the fix.
> 
> Thanks,
> Guenter

OK I think I will give it a day in next and then send it to Linus.
Would be nice to know before that - vacation next week so I'd like to be
reasonably sure things are nice and quiet and everyone can proceed with
testing.

-- 
MST

