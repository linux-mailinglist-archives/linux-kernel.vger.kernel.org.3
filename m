Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01BC5A9DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiIARRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIARRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:17:09 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D825E543;
        Thu,  1 Sep 2022 10:17:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x5so13961115qtv.9;
        Thu, 01 Sep 2022 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZOHdBiwdIYc+dnYpSN1q+dn6Q0Ow16U+F6k+oTcaels=;
        b=jCV0u6Xge8EdKIun7aDa1/g3BBAwXbgj2ECaWYIOUQx+qstpL6S/lDXJJ4NQgshrd+
         dkQi2QxfQCetuXoiCdj3qh5EW/6N5k4hTypZZhBjtxKtazR4VPOws3VZvzsDe9e2mwyB
         yMh8A6bToGuMdAPSY7ogxZkjaQcCX6Bdg9sRMfUsHtfY2vTH2brdYUT9mmBIezhoctxI
         q6fYwfsJznU2g+qjnbu8ZDc5iaPHq6nMGTs/tdt88MLk+XpkAwHuGLsc8zN4cwShm4qD
         LRWhcqIIL7QlVZoaKSw5Tzp6p4zpE2lIMfQDlP2A5bxnQeomTKsLFNRummKG21eSJVo9
         b2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZOHdBiwdIYc+dnYpSN1q+dn6Q0Ow16U+F6k+oTcaels=;
        b=vOtYNmhl7BR+HZuSrcp3nytdayGyQ82yYFjVRFguTUD13l1JjNRLHdK9Xu3YXsRtGP
         sQSeSu1sA30/CN6UIXpHRxtNLLMVGD3sZhdAzwdfDnjjYmsZ+c2wfL1+wLl4ALWfQRwy
         Szdz6UyXv6YhfvHC6RGFSV4gWCUyZvkIGmrkMcH5/zZyirzaPiUw6FLBioyJHAO6ry+a
         dc8oODFfot8MTVRSVamvyVpceWT+CzzYjINkpWPEbWgM3wCnJOACq57u1yaUIgPliewr
         0dCUu6Y/6bQK79d1FD//tur/YjkCy1Qraz6F53N7td+Yalu48OJN9QW975eBGXNd//TU
         59rw==
X-Gm-Message-State: ACgBeo13WfLhuiaT9q0DIoPbsudsh21+zFtP8g8gmVZH0HJT2R4XlgiE
        anWq7v3j4+PYkhydJrxXGtBW72N0m/FOEk8xKLU=
X-Google-Smtp-Source: AA6agR5CqN3nI7KOHP0szFvgAi/dLNLUo0fWAahY13BBukxRKSVN/mrtigRzRoN61PnDThy/C+Md32/m4jfIrwk8ABU=
X-Received: by 2002:ac8:7dd0:0:b0:344:afc1:b11d with SMTP id
 c16-20020ac87dd0000000b00344afc1b11dmr24103252qte.195.1662052627885; Thu, 01
 Sep 2022 10:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220829201500.6341-1-mario.limonciello@amd.com>
In-Reply-To: <20220829201500.6341-1-mario.limonciello@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 20:16:31 +0300
Message-ID: <CAHp75Vc3v4a6=ZJnOYYFGHEomExxopuUy8axDL=M2tbxHqtXqQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers
 that use struct wmi_driver
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:20 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The WMI subsystem in the kernel currently tracks WMI devices by
> a GUID string not by ACPI device.  The GUID used by the `wmi-bmof`
> module however is available from many devices on nearly every machine.
>
> This originally was though to be a bug, but as it happens on most

thought

> machines it is a design mistake.  It has been fixed by tying an ACPI
> device to the driver with struct wmi_driver. So drivers that have
> moved over to struct wmi_driver can actually support multiple
> instantiations of a GUID without any problem.
>
> Add an allow list into wmi.c for GUIDs that the drivers that are known
> to use struct wmi_driver.  The list is populated with `wmi-bmof` right
> now. The additional instances of that in sysfs with be suffixed with -%d

...

> +/* allow duplicate GUIDs as these device drivers use struct wmi_driver */
> +static const char * const allow_duplicates[] = {
> +       "05901221-D566-11D1-B2F0-00A0C9062910", /* wmi-bmof */
> +       NULL,

No comma for the terminator.

> +};

...

> +static int guid_count(const guid_t *guid)
> +{
> +       struct wmi_block *wblock;
> +       int count = 0;
> +
> +       list_for_each_entry(wblock, &wmi_block_list, list) {
> +               if (guid_equal(&wblock->gblock.guid, guid))
> +                       count++;
> +       }
> +
> +       return count;
> +}

I haven't deeply checked the code, but this kind of approach is
fragile and proven to be error prone as shown in practice. The
scenario is (again, not sure if it's possible, need a comment in the
code if it's not possible) removing an entry from the list in the
middle and trying to add it again. you will see the duplicate count
values. That's why in the general case we use IDA or similar
approaches.

-- 
With Best Regards,
Andy Shevchenko
