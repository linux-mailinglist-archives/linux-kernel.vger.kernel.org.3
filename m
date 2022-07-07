Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179F756AC78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbiGGUHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiGGUHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:07:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758C25C9E9;
        Thu,  7 Jul 2022 13:07:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q9so27804681wrd.8;
        Thu, 07 Jul 2022 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFb/vVTHpa3YmcpTqh1lfRYgalrYlOtPO+3lLKx7e2w=;
        b=GRVmiFJd3x6IvVxVUAvexPqEe1BIH/ydII5rQVpCfECXWFdDLVbC0CkVpi3URstvFx
         SIIkJbBtkW5kyU/4SQszTwmD/+FayV+yCJTniXICKSLR+xkzwl/o6sn+6ciOjpfkv5U9
         iaWwNYSQFK41TalfJNN6/fTwGAgmqkOWoXAcaQRC4MijpK+qK+7d8/A7xwBxnw8TEe/C
         fC4GX9lTrLRiHcWYw2IJk5pqRpJWq6RGaY00V4Icb/eu5r/80qkqrIvaA/IOTDFBJdNc
         e8IagkcRYVqASRasxb/qGS+8V4J+6xLmJ/oNyIj3hb7iqcLQivDQwDZp1HsFMn/ERPFQ
         sL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFb/vVTHpa3YmcpTqh1lfRYgalrYlOtPO+3lLKx7e2w=;
        b=dKQxhu/B1N3Wtr8/u+ZBkYcBSF9Lcv05vT9Sioa6oDKd4r0w0ulpUJQmSVDPv+VUr2
         B4komGQUOsOrfATvlesL3k53dkx3EBw9rtbJyldfEb0fUK5pksyua2UMzz0r8KPkNPAy
         E5enzM/kPwVWVy/uBj7xq6OwHHhDFAsT7xrkoJPTrnL5jm8V7Fm0BRxawTbfOzQUCUCX
         QJlrW8zzWPWyN6dwF54b6+CaI/rFzLDuABWUl7y+omGvTMUKcPLNQ1GD488MzkD8RtZg
         6I8aIC3FPWCvgpK6AeCeTlgq59WyWC+i/bYgfNKRwWOBGLJKaRdsTQ1Cbuvwq6WZg2Hx
         3tXA==
X-Gm-Message-State: AJIora/75sx0CKlFVQyjmvC/szzpMyQQQiUsC5PnKoxle9+qpGuoJvvn
        JXHT2yn7V+yCSKAT/jfwDPA=
X-Google-Smtp-Source: AGRyM1uVn2DUfu47zHuV+A0ZwIoNSEY3jvQTT71rKq6YEHsh99Q9rdGTiuSk3+fVCiwUR87mDnXbxw==
X-Received: by 2002:adf:f646:0:b0:21d:7000:95b1 with SMTP id x6-20020adff646000000b0021d700095b1mr17651897wrp.486.1657224455913;
        Thu, 07 Jul 2022 13:07:35 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0039ee391a024sm25096752wms.14.2022.07.07.13.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:07:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RESEND PATCH 0/3] staging: media: atomisp: Convert to kmap_local_page()
Date:   Thu,  7 Jul 2022 22:07:15 +0200
Message-Id: <20220707200718.26398-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
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

After waiting months, I'm resending three conversions to
kmap_local_page(). I'd like to ask if there is anything which prevents
these patches from being accepted.

Please note that these patches were submitted on April 2022.

For you convenience here are the links to the patches, the "Reviewed-by:" 
and "Tested-by:" tags:

[PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_store()
https://lore.kernel.org/lkml/20220413225531.9425-1-fmdefrancesco@gmail.com/
https://lore.kernel.org/lkml/Yli+R7iLZKqO8kVP@iweiny-desk3/
https://lore.kernel.org/lkml/2d096f20-dbaa-1d49-96e9-a7ae6c19f7fe@redhat.com/

[PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_set()
https://lore.kernel.org/lkml/20220413212210.18494-1-fmdefrancesco@gmail.com/
https://lore.kernel.org/lkml/YldNhErgt53RqYp7@iweiny-desk3/
https://lore.kernel.org/lkml/0b04ad1a-e442-1728-ef2c-bab386a4c64c@redhat.com/

[PATCH] staging: media: atomisp: Convert kmap() to kmap_local_page()
https://lore.kernel.org/lkml/20220408223129.3844-1-fmdefrancesco@gmail.com/
https://lore.kernel.org/lkml/b0aed731-b56f-4378-b50e-fc0cbccbdb84@redhat.com/

Fabio M. De Francesco (3):
  staging: media: atomisp: Convert kmap() to kmap_local_page()
  staging: media: atomisp: Use kmap_local_page() in hmm_set()
  staging: media: atomisp: Use kmap_local_page() in hmm_store()

 drivers/staging/media/atomisp/pci/hmm/hmm.c | 22 ++++++---------------
 1 file changed, 6 insertions(+), 16 deletions(-)

-- 
2.36.1

