Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268EB4DA367
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351464AbiCOTkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351443AbiCOTka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:40:30 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6A2B1AD;
        Tue, 15 Mar 2022 12:39:12 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 13so299637qvq.8;
        Tue, 15 Mar 2022 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vtpi8KqEblfOcUZ0Pw5p0t2W/KlA+6v+4V+RQUI8IgQ=;
        b=ANAUT6DcYlkHmQleHKtW+nR4/iCBpy7Rfe7yv/ZfiacbzPp9P1eGNXLYpYzX2rA0tc
         V7FwAuUBRLttYV4TTs33laSYXdtzLtzAFBejd755ZYZVbGH75mIVidrx+VCIm3XZq1qk
         T9Gu58gVqDWjtcAuZgIHsqtPrYsBck4P5ENUf75dxOXMuGbuDWh2wpeZtlYEJlWM7aVp
         4F1Bju+Dke/itdxE07b/GiW1v4EIVZrHkqqdlThItvpMD9TzkgU/6VOnLt0+/A5wol16
         X7QqKH3kop0RiHxN5abv3o7NTVqk0HmCFPey0vIXCXjKr9XLvDTcYyF8dRyRVGZ5Cczr
         cMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtpi8KqEblfOcUZ0Pw5p0t2W/KlA+6v+4V+RQUI8IgQ=;
        b=w3dNkNqiHq4bE7jMprtjng1dRCPJwabYPuRLFy+fjVEWegjPi7PGPCQe3xakkTRIQg
         t2wO0aCwVtN2LN735gu5L+bpLZTZNeqJYRyKNxT7untI2/JG1ueb4OWyC2WS9Qw8x3OL
         5IEYobikBSRIVDkQlDE/mgcM/tiO74sOmkhSlAIdl29e48NVBeRylIVRjrxAfWdLx38S
         wut3VE8UVyOOF/5ZSMif9JTVm3HRZo4Wz/SeFY+6m638n6hU/R3rE+bideEc1J3MzmP9
         M1ygNQgbVfDwga2TaHnBxxiQOqmy99KDL09JzG9fjN+ItTmPiD4KNQFQpXQOOnDJqPvd
         y/uw==
X-Gm-Message-State: AOAM533dHF6TX6vHjgeWWRve7yGOLH1t8DU0ao25lK7Q0H/d4CijuPe8
        4GhES3rGtb7JtFASEGXXJLo=
X-Google-Smtp-Source: ABdhPJw3c0Gc+qsu1VcCFc5QY6piefkAaumx9XPYdozaQ4sDIixhK9+tK9nKpu6duS8AbGUkbfknFQ==
X-Received: by 2002:ad4:5d4c:0:b0:435:41df:faa2 with SMTP id jk12-20020ad45d4c000000b0043541dffaa2mr22679848qvb.73.1647373151431;
        Tue, 15 Mar 2022 12:39:11 -0700 (PDT)
Received: from ishi.. (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b0067e02a697e0sm1440798qki.33.2022.03.15.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:39:11 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Tom Rix <trix@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH 6/6] counter: add defaults to switch-statements
Date:   Tue, 15 Mar 2022 15:38:57 -0400
Message-Id: <b98d1a3ed4b0b324b261b23defd1bdddddba4d44.1647373009.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647373009.git.vilhelm.gray@gmail.com>
References: <cover.1647373009.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative problem
counter-chrdev.c:482:3: warning: Undefined or garbage value
  returned to caller
  return ret;
  ^~~~~~~~~~

counter_get_data() has a multilevel switches, some without
defaults, so ret is sometimes not set.
Add returning -EINVAL similar to other defaults.

Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20220227161746.82776-1-trix@redhat.com
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/counter-chrdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index b7c62f957a6a..69d340be9c93 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -477,6 +477,8 @@ static int counter_get_data(struct counter_device *const counter,
 		case COUNTER_SCOPE_COUNT:
 			ret = comp->count_u8_read(counter, parent, &value_u8);
 			break;
+		default:
+			return -EINVAL;
 		}
 		*value = value_u8;
 		return ret;
@@ -496,6 +498,8 @@ static int counter_get_data(struct counter_device *const counter,
 		case COUNTER_SCOPE_COUNT:
 			ret = comp->count_u32_read(counter, parent, &value_u32);
 			break;
+		default:
+			return -EINVAL;
 		}
 		*value = value_u32;
 		return ret;
-- 
2.35.1

