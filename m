Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5946298A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 02:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhK3BVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 20:21:08 -0500
Received: from smtprelay0036.hostedemail.com ([216.40.44.36]:60154 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230411AbhK3BVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 20:21:07 -0500
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C0DFC184B2559;
        Tue, 30 Nov 2021 01:17:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id DFFEB200027C;
        Tue, 30 Nov 2021 01:17:39 +0000 (UTC)
Message-ID: <51f8bfafb7543098a0f6274f6b8dd61446f3fda5.camel@perches.com>
Subject: Re: [PATCH] staging: replace snprintf with sysfs_emit
From:   Joe Perches <joe@perches.com>
To:     davidcomponentone@gmail.com, TheSven73@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Mon, 29 Nov 2021 17:17:45 -0800
In-Reply-To: <21e2111f6c2590ac24ad15d39e87160f9425045b.1638186054.git.yang.guang5@zte.com.cn>
References: <21e2111f6c2590ac24ad15d39e87160f9425045b.1638186054.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.90
X-Stat-Signature: n6fdcdyytuxaoqnbeaxs3gkugnpmqdpq
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DFFEB200027C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+mAvjVQPrIAu92Rvh7Dcxa0Fxl70E2He8=
X-HE-Tag: 1638235059-32403
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-30 at 08:07 +0800, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> coccinelle report:
> ./drivers/staging/fieldbus/dev_core.c:73:8-16:
> WARNING: use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Please convert all the show functions and not just 1 of the 6 possible
cases.

> diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
[]
> @@ -70,7 +70,7 @@ static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
>  	 * card_name was provided by child driver, could potentially be long.
>  	 * protect against buffer overrun.
>  	 */
> -	return snprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
> +	return sysfs_emit(buf, "%s\n", fb->card_name);
>  }
>  static DEVICE_ATTR_RO(card_name);
>  

---
 drivers/staging/fieldbus/dev_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 5aab734606eae..9c85bf87a8d7f 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -28,7 +28,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 {
 	struct fieldbus_dev *fb = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", !!fb->online);
+	return sysfs_emit(buf, "%d\n", !!fb->online);
 }
 static DEVICE_ATTR_RO(online);
 
@@ -39,7 +39,7 @@ static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
 
 	if (!fb->enable_get)
 		return -EINVAL;
-	return sprintf(buf, "%d\n", !!fb->enable_get(fb));
+	return sysfs_emit(buf, "%d\n", !!fb->enable_get(fb));
 }
 
 static ssize_t enabled_store(struct device *dev, struct device_attribute *attr,
@@ -70,7 +70,7 @@ static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
 	 * card_name was provided by child driver, could potentially be long.
 	 * protect against buffer overrun.
 	 */
-	return snprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
+	return sysfs_emit(buf, "%s\n", fb->card_name);
 }
 static DEVICE_ATTR_RO(card_name);
 
@@ -79,7 +79,7 @@ static ssize_t read_area_size_show(struct device *dev,
 {
 	struct fieldbus_dev *fb = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%zu\n", fb->read_area_sz);
+	return sysfs_emit(buf, "%zu\n", fb->read_area_sz);
 }
 static DEVICE_ATTR_RO(read_area_size);
 
@@ -88,7 +88,7 @@ static ssize_t write_area_size_show(struct device *dev,
 {
 	struct fieldbus_dev *fb = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%zu\n", fb->write_area_sz);
+	return sysfs_emit(buf, "%zu\n", fb->write_area_sz);
 }
 static DEVICE_ATTR_RO(write_area_size);
 
@@ -116,7 +116,7 @@ static ssize_t fieldbus_type_show(struct device *dev,
 		break;
 	}
 
-	return sprintf(buf, "%s\n", t);
+	return sysfs_emit(buf, "%s\n", t);
 }
 static DEVICE_ATTR_RO(fieldbus_type);
 


