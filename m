Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA1A5A9BFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiIAPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiIAPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:44:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFD88A6FE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:44:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gb36so14691223ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=X9TkxGm30JDjWARGuFmbzcO8RfGNjjRnE8hsb1N4Q70=;
        b=ZaHC+Y5AP1c03V8qhdITHExLmiTwCrW/+/Uyfe1Ky6DsOUPkQGHu6WtmQObhDoDl9c
         29o9yVtpdXOfHIJf8JGaHW2JUeh7jYrsXY+EZtMogRkEygMc0/1TDHNbHCl9iaH4FzEO
         CD4q+AHnOxtVqp5sAr/jDiJCsR9a+suPI+xBNlKEmxJY/322+l/RaIfbxjaKk1gMMMgp
         jU37MEqNHmW7eieyZHfU0wQ0/SC0E7uWuMjQsPyjK3tHBYAzdIaYbMLK8YuB/LJ1lYeB
         qP4CfRamVXeZ+uTqOXBCtl3GUVIH9kmhiDgm6OcUif/xvu4dfbtNtxW/UUm88YSPVn7Z
         ARSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=X9TkxGm30JDjWARGuFmbzcO8RfGNjjRnE8hsb1N4Q70=;
        b=cfAso0KubG1sHXDiR57CiWCMMZdO/4ec/QSV+nRgb0aeZj+M+BMryoo2+QbpgbZGFy
         eh6oZBldKNiWj/ZLhH5IX8DnX14EnD6+9W37k6kIa8SJaOhb+YyjBm0EvBxlfvoufTNp
         JP0Q51UUzHxfRXWQKNSLRaHeHZjiqYKlspim5JJOp52w4mA2hYqmkS3l3gZm8aePCSyq
         5CTf19IDQjelpxTcnZmJ88biMg8e3NwNu3d+ddjm+jeWkqpwtox9wsXDeesdTQJjUdJV
         tSlsRle4D9btNCAjUhziQqtGJWIduGGHIjLmp87mjLp1zpIiti9S/IaYiDlzKxKmm0Y/
         lDiQ==
X-Gm-Message-State: ACgBeo1lshEHCNaPzLEkpsXBCu1S21jaoc4BbtvWQ1e+yjyALLcm0v8Y
        RJuLBWgzIRAgLy2HhiQVx0E=
X-Google-Smtp-Source: AA6agR5UVEurzwcqHlAeDlwAjr8NH++iji61O0KkBI4QrYeHYE8RiaNb6YGQObanRyYgVyo6wmdPLA==
X-Received: by 2002:a17:907:7e8e:b0:741:362a:9678 with SMTP id qb14-20020a1709077e8e00b00741362a9678mr18875131ejc.499.1662047053287;
        Thu, 01 Sep 2022 08:44:13 -0700 (PDT)
Received: from localhost.localdomain (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906198600b0073dc6def190sm8576682ejd.158.2022.09.01.08.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:44:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/2] misc/xilinx_sdfec: Replace kmap() with kmap_local_page()
Date:   Thu,  1 Sep 2022 17:44:06 +0200
Message-Id: <20220901154408.23984-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This short series is aimed at replacing kmap() with kmap_local_page() in
misc/xilinx_sdfec. This task is accomplished in patch 2/2. Instead patch
1/2 unmaps the pages which are currently mapped in a loop with kmap()
but which are never unmapped with kunmap().

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Fabio M. De Francesco (2):
  misc/xilinx_sdfec: Call kunmap() on pages mapped with kmap()
  misc/xilinx_sdfec: Replace kmap() with kmap_local_page()

 drivers/misc/xilinx_sdfec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.37.2

