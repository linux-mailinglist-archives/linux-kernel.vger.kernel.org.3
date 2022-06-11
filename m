Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699C954753A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiFKOGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 10:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiFKOGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 10:06:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62A52BF9;
        Sat, 11 Jun 2022 07:06:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z17so1858831pff.7;
        Sat, 11 Jun 2022 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m1nMFyyZYmGMBRRzY6Mchg0mSOon02lwUR8mirsqJzk=;
        b=pxgFf81gGsGawTSJEg2OmiI502GW6bZ4fOm278VqA+mcf2lcg4BWNq2eIbmZW0RXO0
         1MkWN+yP7N8If2KwdLJbPEvqBlwxv2kpr9qlwGnonHPkOiwp3Xd4ksvGDwBf/pRYiHlq
         Sj32DQWvK1J9J7/3FmTrSc/8YEhTT/irw52cUMNCUOiiAjM4X09wxryXIIfzBuv9YiTj
         NlHvbDL9NgTY0IU4ofS3XlgBG+ZpbXb+lPi+iqUTEWAZ9fGKUCkDWaBZwOXnVGcOpm3i
         FY9JJ+D3zVdAcsY2L1j51K9zDNcguot4riL/KoORLDp7EhXlf8QLxtTJS2Zqw/oIiBa8
         ctSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=m1nMFyyZYmGMBRRzY6Mchg0mSOon02lwUR8mirsqJzk=;
        b=Tb2OsKMwgek90rK1JVJ+XG+ojz55PRsH8FA3nZF766fm/zhOukDGm5QeKQ43E1o66Z
         d2euP3YwBIAI7OwaR+FgUxl74HzYDaTJhmIU/kXXD/+Bgkhtr1hGLBi4hcwupQRYl6fS
         0c1K+otqPAnFo4TGaGiGuQMWnfh1IY9FK7oNLc9KWUJtLDtUAaj08u3G9eCWKhY1Qd8o
         /kva3m/bcQvztxpsY0eG2u8pF+EsXct2xMum0oBHasE5ax5glFO50jxHPn1zkbE8o5hl
         O1KYC6EYYPdDoiAJdcBxs2EEK6rfEEKX1CEpmORD4uJrbkiPsESG+xE2sMWJYvKDHCQg
         MQqg==
X-Gm-Message-State: AOAM530e1N/CHvFqadcrdrpUpmI3iaRMvnb7CMIm1OLEHQj7AVK46ywY
        kBHekT7WUUjLcmJVvZg2y1I=
X-Google-Smtp-Source: ABdhPJzkHo8bKp71V7Uba9Xeig94RmbX9Jr8edlwTnZbMFIYrAIzy0t78X7b7jiWLpUVrYy3n1IFhw==
X-Received: by 2002:a05:6a00:17a0:b0:51b:c7a9:bf0c with SMTP id s32-20020a056a0017a000b0051bc7a9bf0cmr48664605pfg.71.1654956391085;
        Sat, 11 Jun 2022 07:06:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n6-20020a17090a928600b001df239bab14sm1476256pjo.46.2022.06.11.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 07:06:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 11 Jun 2022 07:06:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/1] hwmon: (nct6775) Drop duplicate NULL check in
 ->init() and ->exit()
Message-ID: <20220611140629.GA289033@roeck-us.net>
References: <20220610103324.87483-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610103324.87483-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 01:33:24PM +0300, Andy Shevchenko wrote:
> Since platform_device_unregister() is NULL-aware, we don't need to duplicate
> this check. Remove it and fold the rest of the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Zev Weiss <zev@bewilderbeest.net>

Applied to hwmon-next.

Thanks,
Guenter
