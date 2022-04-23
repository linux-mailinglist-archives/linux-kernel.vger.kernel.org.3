Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0D50C5A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiDWALx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiDWALt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:11:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B6A3D1F8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:08:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s17so14162528plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8rhM0AUb28XSifpCDXIdOqSJ0aXgis9HwJ8WeGFTvA=;
        b=Xo+AVVSSyCqyl6ckW7mfe0Iwmo4zy/V4+U2hF6gPGUNtJcEYoN6mTkc23bEcCHz3W3
         XxkljElQVQh93aBFm+72UaoPCi175LJHN1iV+AdzJcJA58Ri76Q1OfE1/joS8U9p9/2z
         iDwMa8UrQvMSsNKEFJhLYQ3Dn57PNdq+qVrH0RKjuX3pbD+FMLt5Lk0UJKVQ6vejHQrn
         U0oKpbwqz8JOldgBXzAHf+OHD6T/H8f1N+npIeWcevHpAH6rmtgmuA6TsQNj6oEEmmWk
         8+jsj8mZIpQuOtmihV1P12NvbzEGFBwkE9SuYTb1sqvwo8UODX5G+7sCxQIJLF62/mKa
         Yffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8rhM0AUb28XSifpCDXIdOqSJ0aXgis9HwJ8WeGFTvA=;
        b=deOXx+DNIb4+POkJa7DoCxhAaBN9oF/xc72ic4Q7TRWP4/C3jEjijp7ntMG6LibaRH
         VDcMZiUxBc8C3zmkyihSyPoBduH7URCzxyPJgwAtyBrysInQTdqhFxJdoxYvsoCmkac0
         3ZHI4orQlc9Lc/MK8cjRuvbm0PQ5Wkb7azU7A5JmTkt8ZiqIC9OW57fYeg0/RowQAMmy
         h+RKMDWa0F4IAdlmPDI9ZCXDqYbZigTBZxn2s7+CEoJ1oIO4LzFA1v+IrY9yAgMGzTRK
         T31tX5pRWF2SNtTCqWBunFes7SrVF1NdXc33aWq7ZEkMbezknOGsZ4rUeHyo5Qu/Uouz
         PtQw==
X-Gm-Message-State: AOAM531hJTaGmCd1XMZhjfm6pJcH4ymjsQ0SA5Jx54ApRzFYbPKaSqHO
        7AsJcGfWEeXaI3SGW7SQYgwqnNk/xPedfxenEII6vw==
X-Google-Smtp-Source: ABdhPJzQ6kd9z32Km/IESdCoiX/cv1J1qD5/s745g8GFGUBao7YJJIoB6xbB0cmsgfrtl1R71Fx0fgm/TB3crzcaBoA=
X-Received: by 2002:a17:90b:4c84:b0:1d2:cadc:4e4d with SMTP id
 my4-20020a17090b4c8400b001d2cadc4e4dmr18959361pjb.8.1650672533937; Fri, 22
 Apr 2022 17:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055519869.3745911.10162603933337340370.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YmNBJBTxUCvDHMbw@iweiny-desk3>
In-Reply-To: <YmNBJBTxUCvDHMbw@iweiny-desk3>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Apr 2022 17:08:43 -0700
Message-ID: <CAPcyv4jtNgfjWLyu6MtBAjwUiqe2qEBW802AzZZeg2gZ_wU9AQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] cxl/acpi: Add root device lockdep validation
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-cxl@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 4:58 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Thu, Apr 21, 2022 at 08:33:18AM -0700, Dan Williams wrote:
> > The CXL "root" device, ACPI0017, is an attach point for coordinating
> > platform level CXL resources and is the parent device for a CXL port
> > topology tree. As such it has distinct locking rules relative to other
> > CXL subsystem objects, but because it is an ACPI device the lock class
> > is established well before it is given to the cxl_acpi driver.
>
> This final sentence gave me pause because it implied that the device lock class
> was set to something other than no validate.  But I don't see that anywhere in
> the acpi code.  So given that it looks to me like ACPI is just using the
> default no validate class...

Oh, good observation. *If* ACPI had set a custom lock class then
cxl_acpi would need to be careful to restore that ACPI-specific class
and not reset it to "no validate" on exit, or skip setting its own
custom class. However, I think for generic buses like ACPI that feed
devices into other subsystems it likely has little reason to set its
own class. For safety, since device_lock_set_class() is general
purpose, I'll have it emit a debug message and fail if the class is
not "no validate" on entry.

Thanks Ira!
