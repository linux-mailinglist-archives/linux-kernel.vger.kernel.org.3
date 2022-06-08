Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217A2543B5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiFHSTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiFHSR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:17:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70692B41E9;
        Wed,  8 Jun 2022 11:17:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g205so19009484pfb.11;
        Wed, 08 Jun 2022 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=zet8osd5nLPQz3oBe73Zqkjg49dA/mLJAWeA5oyZgNc=;
        b=gznNOJx2q3HHwRU/vXMQEhXkx0ZDe/ClZSgZE90leL4se9+z/rkgkJgci31UnXxqGa
         pSFmDAV+KQ/m0lAMBWDv3BwEjRWzkjNkczSWMGqRWANlHNVeAjLbvNv0VgtsJLSZFaGN
         rMAoXzurC+ksXW9ifq1N61vUpBNDSLW1nOSoKqMt80o1qHIHevYxhH5ChyCyOijuVeWd
         EcMVG1uhwm6qQyQ1La9YqKhGs5KvevA4t1771Q28WgXIZufuh+ZH1bAfQIZuJyQuOCfA
         aTA2d14H9NmsmkTlbDpT6b2bvvDTPgr6XjYiwsQLbapk21aix6tYegOmkO/0RdZxEdOv
         cyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=zet8osd5nLPQz3oBe73Zqkjg49dA/mLJAWeA5oyZgNc=;
        b=gT1xishbNPccgz3YPsVz1KtzAX8GVpn31QPBu5VtMP2f2dFd9oQJXBt8LsyIjM0c1h
         UVC2ZdDnUPYkoj2y/2g2WRxO9nAm5FaEDKz/NlgqwrFG+5DFxjKX3GOcHOgVpxHqw1Wx
         u88LTDAQ/DEoi+AUDTtxbV6+B8Ff6IOcHscbpnh0/m/SNJuc8hebtq0myt8ey9US3Nyl
         aA7Ak9Cs1kwH2VjDGbnMYFMmi+etl+H3TJMXHP780ijEMVJWH6uTCxdN08QXYhbSaSnK
         ZSSLky2rZkeUiwKhwSnJ/2DD10GOmirEL+w4skwlagkdQr8sAQlN/kec0PPLiw0rBde8
         0wuQ==
X-Gm-Message-State: AOAM5307kRr49s5bJjQC6it1HCAaVfUfTn21vKTjgrXUASnwpfipi5G0
        PDCR8JFryqthvIHwhYxr6wr4bn4s1WAT5w==
X-Google-Smtp-Source: ABdhPJw4IBP98O87UVzcQWYGyt8VGxGjhv1L2/x8qSb8M+AC7+L/IJaBTKiibfNreq0M0hhTyIOeyA==
X-Received: by 2002:a05:6a02:19c:b0:3aa:1bf8:7388 with SMTP id bj28-20020a056a02019c00b003aa1bf87388mr30944392pgb.455.1654712267938;
        Wed, 08 Jun 2022 11:17:47 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([106.212.247.119])
        by smtp.gmail.com with ESMTPSA id o3-20020a625a03000000b0050dc7628142sm15375484pfb.28.2022.06.08.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 11:17:47 -0700 (PDT)
Date:   Wed, 8 Jun 2022 23:47:42 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: musb: remove schedule work called after flush
Message-ID: <YqDnxkWZV2KfZh5q@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

In musb_remove() cancel_delayed_work_sync(&musb->irq_work)
is called which flush the irq_work work queue.

After cancel delayed work, musb_remove() call
musb_gadget_cleanup->usb_del_gadget_udc->usb_del_gadget
->usb_gadget_remove_driver->usb_gadget_udc_stop->udc
->gadget->ops->udc_stop(udc->gadget);

Where musb_gadget_stop() call "schedule_delayed_work(&musb->irq_work, 0)”
which is already cancel/flush.

So remove the schedule_delayed_work(&musb->irq_work, 0);
from musb_gadget_stop function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/usb/musb/musb_gadget.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 51274b87f46c..daada4b66a92 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1910,8 +1910,6 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 */

 	/* Force check of devctl register for PM runtime */
-	schedule_delayed_work(&musb->irq_work, 0);
-
 	pm_runtime_mark_last_busy(musb->controller);
 	pm_runtime_put_autosuspend(musb->controller);

--
2.33.0

