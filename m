Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615E8564684
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiGCJso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGCJsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:48:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A035B7663;
        Sun,  3 Jul 2022 02:48:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 5so234304plk.9;
        Sun, 03 Jul 2022 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oiH22WBwxNe4iZftLgTmVues81FNsgN3x6fpbRHkQQs=;
        b=pfJz87kay59E1D2tI6KeT+kzTagw+uwOsUPbzI3oFtNwCEBwi9JhYu5VAWSHMG+M2F
         ul9LAedN3eWN01UuQplHaJcmLkwytzIypq+JStfVenXgeTy6gySpYZII0qBeRE/3ZLYS
         +0Yrq1nk7m3lWdJMc1FUquYs9c3ZM3oqHlxiF8pkiQ0UxTm4nHDLK+4dvGmYIoEvGury
         Be2Qnwj/mnJ3KmH4G4277DQPSi1szmPsk4/8z9hQBcYQ/aIq6sG6UqpXbjR8+/uWnB6u
         p0kdx9hg3VC7LkMB1+IMJ/Z9nIHRsKW+fMrLVwkiv9Oiz/tWVBu0AxGj2HinvvGcsZ2O
         c5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oiH22WBwxNe4iZftLgTmVues81FNsgN3x6fpbRHkQQs=;
        b=7egahj+uFMoh0zftp+/aRdpM4BkYGTEsrA6MKa4YQms5PB2pvQWo2CY9xmyEEbawJP
         bHicUMgOVAGMrMWEQJN2SulrADPxGv640MZUEBh1bGBmwkEZXsDn/CWg9CRr6MWx7OFY
         pwH5iugnJbRcLmX46+one0vbnvvw/Y2xNboCJbm08cPvPUPpCM/QfSk6Qa9oJCQDhPbm
         l6TGT3MCVws0xYh8YpRkGt4iK0GNxWt+Lus0HAlwLIU0YVcHt3rZeaJbKEeqOqpWfF9u
         +wd2nfjyC0N2FOkZ7TDADI9xd8nI2+M3NyHMlgpTNKkyaxk8CRwTnNICfKTfhs9sIfWM
         5Nqw==
X-Gm-Message-State: AJIora+5zkhx4b6rLs/npQ/li+UcZQ6xkOpuQlkILapA+EPfyz42qwkn
        V1vPgRkb3+hSddffbbbHQ0rDDUON/VXw8g==
X-Google-Smtp-Source: AGRyM1ujsJltvmMK0T1qg3zAkixRgxfPxhtfeYayFJkUiB/pzwFFb7lL4pAcwPCSvKNI06+Leb14qg==
X-Received: by 2002:a17:902:bb90:b0:16b:8a74:3aad with SMTP id m16-20020a170902bb9000b0016b8a743aadmr29061269pls.47.1656841722124;
        Sun, 03 Jul 2022 02:48:42 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-73.three.co.id. [180.214.232.73])
        by smtp.gmail.com with ESMTPSA id be9-20020a056a001f0900b005251fff13dfsm18659763pfb.155.2022.07.03.02.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 02:48:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7457D10387C; Sun,  3 Jul 2022 16:48:37 +0700 (WIB)
Date:   Sun, 3 Jul 2022 16:48:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9324: add empty line in front of
 bullet list
Message-ID: <YsFl9YoSn2YUDHAk@debian.me>
References: <202207021703.lEW6FLT1-lkp@intel.com>
 <85c5fe48-90fd-6ad6-72d8-a3e7929f23e4@gmail.com>
 <abcaa4f5-7a9b-56b5-c11a-a88fef9d1e0a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abcaa4f5-7a9b-56b5-c11a-a88fef9d1e0a@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 01:27:47PM +0900, Akira Yokosawa wrote:
> "make htmldocs" emits a warning of:
> 
>     Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected indentation.
> 
> This is due to a missing empty line in front of the bullet list.
> Fix it.
> 
> Note: The line count of 2 in the warning is not exact in this case.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> Link: https://lore.kernel.org/r/202207021703.lEW6FLT1-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applying this on top of Mauro's fixes [1], no warnings. Thanks.

So I think Sphinx was pointing the culprit at the wrong location, since
the problem isn't lie on the field, but rather on the list.

Mauro, can you please pick this up?

[1]: https://lore.kernel.org/linux-doc/cover.1656759988.git.mchehab@kernel.org/

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
