Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0064E57EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343835AbiCWR4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343825AbiCWR42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:56:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9A2B7D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:54:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id o10so4448642ejd.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=weN60xW+yqBjNWWoUTdrMPjiX49CJMMCVBJR4fB8Kjw=;
        b=fqlUpUyfeeCvvy4DS1MBlL4zf1zHf0FGNm9VHVD2KJnftud6qYw3VVdHyZRiE6wbqq
         QGs3Rc82oQB2i+whThfrlfP7BAozHQn0Nw7ZySToIiKGaY35I2x6XBg0eU1Jml918o7k
         qKI/tblWQsUP7LMn9DwQbUAQqd4VUbJWCckja/+E22eqa1mM66/O0uDtR/A38hkWQbrq
         BpQF9I/sjCIffom8QEWNWfwO0MOzrIIfJScVDQoocqIFF4D/4GCtIt48PIjcX11nZgU8
         zJqST+DCuCsY4Chfp4dBupub4qCmptH/spsFgW66xu857jsfOwA755kNUd9AaoElQt1g
         NQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=weN60xW+yqBjNWWoUTdrMPjiX49CJMMCVBJR4fB8Kjw=;
        b=zyL14Q4Ar6U+XkRIHOgtBnA9Hz1Bmh4c+mOCnbqkr9ERkNc2EqCxJbKYCyhKXOvL2F
         4ABaKkzVERpdlwg6vCsccpC6X23vVGA6wD9pXpDD3kgnXwxy0GZ55RfWxQuQ6BlMEZ6e
         L0IHDEHrJ63cFv3Ysa1NCR2VZ7uTySuwfOkvK4I1Z6ar0Jz5+4/4po2xeAOn7tdb186M
         b1WRNvXoQl98iz20+/4T1slFQ0QNJiin//Bskw2sVqiskgTe+4EFW+iYpTQNr67wJyfw
         SYE+7JxSJF1Onil5B3FQQDzrKPg9o+3WQDItCq7P24GyeGq0LZQjsISMriajY8xOYXGP
         H9dg==
X-Gm-Message-State: AOAM532Q+XBzOisfgB4zntHzQ0E0+T3hwSsdM9noXsH1YaDCfvQVH5G/
        7xxOGCKkoCc47nlq4jniSCfBFZNRH0ZqAspq+1UixPvMVUDCcA==
X-Google-Smtp-Source: ABdhPJxr0IpQG7pZs6NUygXEuK9ANo0Nd+mbzBeVwkIYyn/tb9fH0PYhg8L1O+5rb+0RCKnVMXsQl6LcRLky7N0UR+M=
X-Received: by 2002:a17:906:c04d:b0:6b9:252:c51c with SMTP id
 bm13-20020a170906c04d00b006b90252c51cmr1377573ejb.470.1648058095790; Wed, 23
 Mar 2022 10:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220314195458.271430-1-wonchung@google.com> <CAOvb9yguWiJgeYBb1eTnAUpNQ-f5f-tQDnDNw+XzBXRx0H156g@mail.gmail.com>
 <YjrKYcta2SUjn3Pk@kroah.com>
In-Reply-To: <YjrKYcta2SUjn3Pk@kroah.com>
From:   Won Chung <wonchung@google.com>
Date:   Wed, 23 Mar 2022 10:54:44 -0700
Message-ID: <CAOvb9yi_YYVjT1ZVKE0oOH8GeqgqbDkcsNC2WMwUJFw6J37-OQ@mail.gmail.com>
Subject: Re: [PATCH v6] driver core: Add sysfs support for physical location
 of a device
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 12:21 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 22, 2022 at 09:36:02AM -0700, Won Chung wrote:
> > On Mon, Mar 14, 2022 at 12:55 PM Won Chung <wonchung@google.com> wrote:
> > I am sorry to keep bothering you with this, but can you take a look at
> > this patch for a review when you have time? Thank you very much!
>
> It is the middle of the merge window now, and I will look at this after
> 5.18-rc1 is out.  Due to all of the constant churn in this (and you only
> fixing the memory leak in the last submission), I had put this on the
> bottom of my review queue.
>
> Also, I don't see an actual user of these new attributes anywhere, so
> even if this was accepted, who is going to use it?
>
> thanks,
>
> greg k-h

Hi Greg,

Thank you for the information.

As a start, we are planning to use this in Chrome OS to specify the
physical location of each USB device since Coreboot adds _PLD fields
to usb port and typec connector. Currently, if there is one USB device
connected on the left panel and another USB device connected on the
right panel, the userspace cannot distinguish which device is on the
left or the right panel. Once each USB device exposes its location
info, we can gather more data on users' preference on port usage.
Also, it can apply to not just USB devices, but also other types like
HDMI ports in the future.
Would this answer your question?


Hey Benson, can you take a look at this if I am not mistaken or
missing some details?


Thanks,
Won
