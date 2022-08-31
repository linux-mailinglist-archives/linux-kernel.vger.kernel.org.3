Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C95A7256
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiHaAUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiHaAUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:20:49 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E967CB9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:20:47 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y187so10708477iof.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bxn9VxVOYsV90b/AXcl+X3+2JZebJQygb6zbgA67ISw=;
        b=Sax+ObM4Va+lRmzJXxMoChcy8XRYUkndNMWBeoahPTarzKOmZ1LTVW8XPU++/jAkId
         VwcNtXaxJfXwL5CW/Qyrf84i54KvuKBetFq/9P6Na7HasaWkpIBvyed9a4OopHB07wKq
         jABVmxH5VCkvoy92YucmEexM/2dKC5CHLSCd1wY5FBtIkB1ElEaCS4whihdmsvW3fV72
         brRfMi7fasCZQqzYT5VXDhKoCizFKO2tiybzrK7y+CoSbUkVncuJYZ+rkOlaOolgR7wl
         6BPUbomzUxdtQpAZwp6zyZ7NPnb/JTH0YBVvCUeBd948VCJCNmP5DsyN3OOq2VBbQIKB
         Ifdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bxn9VxVOYsV90b/AXcl+X3+2JZebJQygb6zbgA67ISw=;
        b=yhTlFXzx4WzTePQ/W71gxB/ZtP29iSwfXuGba4ICPWmJfaq5temxAfqcl2hhyx4cNN
         ut1BMKyriZVHx03KPwYEEKbThFj5LHkTQvZAFbqVbYa9Zl8VOEQGJaD9IgUCioesvj5V
         wM06ZpuKvSKoxLfJUWUXFf6cqZ1xAisBUyhdPKkFa2lvPGjmKJLvuuqDcYI1N3TbjTWc
         Vd/UsxYfkgjqSWHJIBOofqX29T82CdZUcB2G0agLUIiZe1xQaIVOqX4t9r5w5o2aEHH8
         QULSTmrgFFtOf0bhoSeEET346DhMtSAAngxRw2WKNqsncDtgDV+rPUxahNqbXBUrSlxZ
         HwRg==
X-Gm-Message-State: ACgBeo2f92KfGR+HHONe+pg7xAd6fM6qOaFkVOaAwn3XnHBK7E6Qx/FP
        fNRsHLt5f31o0M1Pf5Aj/w12l41abRUcD3mUxNAV5Q==
X-Google-Smtp-Source: AA6agR6zE6Tb6rAbgoVoGjxVMOS2HvKQJsnQ103/b24iLrHMlTfvVys1QxPbUMXlSm7+O1yBlpV4SXcGzjERV/4KBjU=
X-Received: by 2002:a05:6638:42c3:b0:349:fdfc:4543 with SMTP id
 bm3-20020a05663842c300b00349fdfc4543mr13316697jab.223.1661905246787; Tue, 30
 Aug 2022 17:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220826084001.3341215-1-badhri@google.com> <20220826084001.3341215-3-badhri@google.com>
 <Yw4J9wv1N2Z5/qbN@kroah.com>
In-Reply-To: <Yw4J9wv1N2Z5/qbN@kroah.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 30 Aug 2022 17:20:10 -0700
Message-ID: <CAPTae5KFmEXKLJD+A-adb7LpFVY3fDKjNXR8W_wBxDaBZkCa9g@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] usb: typec: tcpci_maxim: Export helper function
 for register reads
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>
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

Thanks for the feedback ! Brain fade moment of not including commit message.
Not exporting symbols anymore and I have squashed the patch as well into
"[PATCH v2 3/3] usb: typec: maxim_contaminant: Implement
check_contaminant callback"
which I just sent out.

On Tue, Aug 30, 2022 at 6:00 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 26, 2022 at 01:40:00AM -0700, Badhri Jagan Sridharan wrote:
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>
> As Heikki pointed out, I can not accept changes with no changelog text
> at all, you know this.
>
> Please write a good changelog text that explains why you are doing this
> so we can properly review it.  As it is, we have no idea what is going
> on here at all.
>
> thanks,
>
> greg k-h
