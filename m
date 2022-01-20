Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16358494DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiATMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiATMSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:18:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB4C061574;
        Thu, 20 Jan 2022 04:18:18 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x37so1413496pfh.8;
        Thu, 20 Jan 2022 04:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Ik94/eld5uHGn3bZKP+GwLJe2ovChEc9eeEQCx97DA=;
        b=fabB3iISSP9VCRA/ON+MRMlr44Tb3dhfBGhBTJXPfS/t1oeQHbga2DcV/kTfjLeNeY
         dz5Xi7Xz0s8G48vtK0IactR9wnjZjApjMFDVP9siMUXdqmOWVvWEPI5LEhU1RfENSVt7
         YhiNxqsf75W8Z4iDxcNTPBXJVepgsWbYbHA3gKk8oY4DauCtbCODmH9zmyYfNRMqdAaJ
         bS6oARI9LCLMU/pCAJr+aEdqMlQ+uqvkWFJzF6MGT0ThHDEmPW6qv514SoN1VsF+n2NH
         mIjfENDEMA2TNdMfZWRjkTmIHcM3FH4VCtNowX/dNCBT44SoUCxYcgfaiZUDRI40oroK
         3qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Ik94/eld5uHGn3bZKP+GwLJe2ovChEc9eeEQCx97DA=;
        b=cDefyIKpXK1GfeYM5x2txc671XEu5CqtNQSuHcT/lYH2b+9m1E+sUxxLbz5PSRFTig
         vVP1gY4UMA/Y8LbeYoqrgMxX+EAnCE2Bm4JU1SgOb50Ku1pAX7DKl9kEVEKs3vVerYwD
         tZxVl8SzbUtbWCfe1Z40GwKJKsb/1t13mSkoEAbdllSrJU7UW+uCE3dAafvikFewJVob
         BSeeSVHMB8S0f2Kvdp+iHhhuECFyj3hqUY3GEv51DI9l7KU5nuHFzyZAGlYWq0LZaV4R
         djlCVDZ8I/Ag5ixwsg+g0bAZfkkm45YYB9/IxyquEXeX4Sxeuhrqndq0a8/OpAUuHIga
         jY2w==
X-Gm-Message-State: AOAM532K1u1Gpa/jno/eRDWBzXLSoCJ+n8ZMhGOn17v8/FjtauU5Mt8i
        CAiX/Vv71+xWEXgPO3KybdU=
X-Google-Smtp-Source: ABdhPJziVWpUMMjAt6OqkDffgHJvUinzucSciCJlcXVk2GC0MdW92szy+GiTxOmSUoDL3aAs0KMTjQ==
X-Received: by 2002:a63:2a0d:: with SMTP id q13mr9391353pgq.601.1642681097684;
        Thu, 20 Jan 2022 04:18:17 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id n4sm2307360pjf.0.2022.01.20.04.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:18:17 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] parisc: pdc_stable: Fix memory leak in pdcs_register_pathentries
Date:   Thu, 20 Jan 2022 12:18:12 +0000
Message-Id: <20220120121812.14943-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_init_and_add() takes reference even when it fails.
According to the doc of kobject_init_and_add()：

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix memory leak by calling kobject_put().

Fixes: 73f368cf679b ("Kobject: change drivers/parisc/pdc_stable.c to use kobject_init_and_add")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/parisc/pdc_stable.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index 9513c39719d1..d9e51036a4fa 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -980,8 +980,10 @@ pdcs_register_pathentries(void)
 		entry->kobj.kset = paths_kset;
 		err = kobject_init_and_add(&entry->kobj, &ktype_pdcspath, NULL,
 					   "%s", entry->name);
-		if (err)
+		if (err) {
+			kobject_put(&entry->kobj);
 			return err;
+		}
 
 		/* kobject is now registered */
 		write_lock(&entry->rw_lock);
-- 
2.17.1

