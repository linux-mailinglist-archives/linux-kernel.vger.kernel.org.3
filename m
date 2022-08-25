Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF995A1A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbiHYUNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243488AbiHYUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:13:21 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C9B99E1;
        Thu, 25 Aug 2022 13:13:20 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id l5so11475242qvs.13;
        Thu, 25 Aug 2022 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CxBXybh+XyYwTdI+6deihNorwY+b7o3BjucUmO3qzcs=;
        b=WV8wuXMJzwgYjzqCXonTbj9BbMCvoVv9v3zaJ1+kfFlC1Px6ePsgRpQCEhpi137+pA
         wTukGUdummUx3sCKnrQQYYfRegvxJxuKzCrxOzX4KVUWmqxCQzZe6RgDC2+12+xqatUo
         9XkjZ5YYRzGBYBxi1g1thkafvHRLZSuPsYCxU4LREgHDvCFNGZFb79AmwoDKqeVLEVaQ
         VmMIra1ZOyTH9LUx4oPbYRi7gKaXn04Sz9Kmpk2tjSPpovl9GyUNHqHY276/SZSCahiv
         2Xu1nSEgm0yB51D+wCKr27y6hCW4SRoZD1Pf/8VeDP9PeszYaZIAt4EBYepKLugSu+Md
         TVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CxBXybh+XyYwTdI+6deihNorwY+b7o3BjucUmO3qzcs=;
        b=6guzT9lYXW8aFLJjbdj/xN2+MLucSIszHf8gDzkSEWZ+o2hPFGfKkYdtP9GrZ4IpOy
         EAbAe9PALVPSOVpKohWy7EFgndoeN5u9rN4ok3MwgRPiMBL0XoW9WYZ6lSpE37Xc3Ul0
         sC7EgoAAaf2G8CHc3P+fn0XV79vyawhfh2gaiyxOi7aD0jd7NrjoLEyxd6jQh9qRf7OE
         ZnmLNH5aSLLfQbVpsUWiQr9Mg5Ly49tOiPEe+vzT+WkZSmJcv1+WnC8IMNh6FbYi0pXp
         uFKMChdrktBspR9vEHPJWP7QaVLWseC1oDsE6BRVT9qVcSNALoiik/gAf2AJwNCt2okv
         ArUw==
X-Gm-Message-State: ACgBeo2qyJ1lwKz99PFG7s2ajsQSI32P7rC807KqEWZWyF0vEUN8EJIG
        k17gcqs1BcCqE+8TjN1VhNHDIzA4/u6F4h1lsJ4=
X-Google-Smtp-Source: AA6agR7wav6AkPdzoNCgt29byNue24x8j0mQee95QhPSgT3efgrsS5jyu1tlJCpplKC0L3ic1AL/8pocg19Imub5Qhg=
X-Received: by 2002:a05:6214:2022:b0:497:2c03:61 with SMTP id
 2-20020a056214202200b004972c030061mr3035433qvf.11.1661458399483; Thu, 25 Aug
 2022 13:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220825144012.24a33bb0@endymion.delvare>
In-Reply-To: <20220825144012.24a33bb0@endymion.delvare>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 23:12:43 +0300
Message-ID: <CAHp75VeSgmO_=mXVR4uSpbQDO8MBGZu4O2vLEqunHYuoPfJbbQ@mail.gmail.com>
Subject: Re: [PATCH] iio:accel:dmard06: Optimize when CONFIG_OF isn't set
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
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

On Thu, Aug 25, 2022 at 3:54 PM Jean Delvare <jdelvare@suse.de> wrote:
>
> When CONFIG_OF isn't set, we can optimize out dmard06_of_match as it
> will never be used.

NACK. There is a magic PRP0001 for ACPI case.

-- 
With Best Regards,
Andy Shevchenko
