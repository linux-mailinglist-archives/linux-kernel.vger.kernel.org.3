Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B905A00DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiHXR6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbiHXR5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:57:38 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042414CA0A;
        Wed, 24 Aug 2022 10:57:37 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b13so826984ils.0;
        Wed, 24 Aug 2022 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+VXhj0+Ay3TZpIZhOIKirdlUbEchMg+eeIoWbSwLaMQ=;
        b=FqtlcR6PHeQ8FbGlZamnZDydsLfqdO3pLGS+vY127CjFh6hz/qgMoQMaQ8HBZy6ipD
         Q59V6mtCFsldEsyndmhrSkNtCRhzSLGpQCWcnQhRMlzITXNnBdeDKq9GtPjqHVm0w6Ec
         1nwsRXlq49OgoxJIAWfpeUqG6t0NX1f8uRkKPwFHUNYsgQhQfZgnBFzalBgtXwrH2fUU
         pPY0pYK5Ydml35/Yuunds+vQua/f8U+jGONJ9fCQmpcJ96UNTBKbbWNzkzaHIPNlaLd7
         90JHi+AAih6FCyRY7qjULGx/1o68eov03pnTZRYo0qThVwMtyKcPWXe7yYwKp7+M1Vi2
         hnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+VXhj0+Ay3TZpIZhOIKirdlUbEchMg+eeIoWbSwLaMQ=;
        b=5WeAhDqSleLXSScr2LJQ8IuyBwXi+NW9Q7JchNip1U58yexSB13ADm8vtVpts8KWKk
         M1HICEj+67gS3JzOLoE/3Tn8SDQbmEXIKXVVJHfcUrcsuLImGSg/4gVqCMPGI3yQ5gOq
         uoSVcW8r7AZw7LPtYYM2giH7/7DkhMTxcMjVQxy+yV5CjwHoiMWvUSKp7fOKTBUHehg/
         GnUJcXGrHy49kMwGpwhVk77i63/Jm45AuGX4K9Cs3RObb+bwFRNnzVnMWGnU1skT+M32
         LUCZ/05mJUwZi/mEWL6av96l9I6uiAFqYKux+mvGbavjzzt9CMidJqn/YdxTIWwVk3EI
         yZVQ==
X-Gm-Message-State: ACgBeo0T1AxSH5I5TBAJsu1/1MQD1N4kPloISmBU9AC9Kj3RkAmOvGTQ
        O/HqmtphusgZgndo95bau1fp4jeqfqc01pAUgA0=
X-Google-Smtp-Source: AA6agR5sKcUgOKHc8NyRxfYOHRnWRzz6vHXZxz1MTlpe6CuP8vult6tat6rs88BXsF3sGnLkPhYCTnVAukbOwWMzw7I=
X-Received: by 2002:a05:6e02:20c1:b0:2e9:f747:ad54 with SMTP id
 1-20020a056e0220c100b002e9f747ad54mr118567ilq.144.1661363856349; Wed, 24 Aug
 2022 10:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220824130702.10912-1-khalid.masum.92@gmail.com> <YwY4cVdB3tVVMIqJ@rowland.harvard.edu>
In-Reply-To: <YwY4cVdB3tVVMIqJ@rowland.harvard.edu>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Wed, 24 Aug 2022 23:57:25 +0600
Message-ID: <CAABMjtFEfgQtcGKLkd=whFN=WHUywTg=fDAxRQ+zKLiqOFhvQg@mail.gmail.com>
Subject: Re: [PATCH] usb: host: Use helper function to get endpoint
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexey Sheplyakov <asheplyakov@basealt.ru>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 8:40 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
>
> Even this is awkward.  It's silly to look up the endpoint in a table
> when you already know that it is endpoint 0.  Just do:
>
>         ep = &udev->ep0;
>
> with no need to check for NULL.

After further checking, I realized that  usb_device udev is created by
ehset_single_step_set_feature and depends on usb_hcd and port. So I do
not get why the endpoint is at udev->ep0. Can you help me with this?

-- Khalid Masum
