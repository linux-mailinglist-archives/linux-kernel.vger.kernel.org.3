Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA16470585
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbhLJQZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:25:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240860AbhLJQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639153289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRTa1IW1x5mHDhMMijsmQ1M232y0DfMQoKwLDpRfU1o=;
        b=Xp5nDaLREY85Lke1ZeGQ0cCtFd9x4LXPEaCMQVObdo0Bb/KDUHn7+pjkwSUqLnybdo1ssd
        xllW2jrqhGQ5EZYlHX5Af/JoBqbr50zvB2PCt8IW12dMJx/VGQfc/6oAdgc+KN64MHVU1/
        4SHJJNTHfKIYzU8lxIx8xjFL+GB8C+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-iQBUMMxOPJi2OR4Tal-DFA-1; Fri, 10 Dec 2021 11:21:24 -0500
X-MC-Unique: iQBUMMxOPJi2OR4Tal-DFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22F79102C8B8;
        Fri, 10 Dec 2021 16:21:23 +0000 (UTC)
Received: from [10.39.192.155] (unknown [10.39.192.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D0847A220;
        Fri, 10 Dec 2021 16:21:21 +0000 (UTC)
Message-ID: <c8854f9b-8200-ee10-fe83-77a776ddff95@redhat.com>
Date:   Fri, 10 Dec 2021 17:21:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCHv4 2/5] HID: hid-input: Add suffix also for HID_DG_PEN
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
References: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
 <20211210111138.1248187-3-tero.kristo@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20211210111138.1248187-3-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Dec 10, 2021 at 12:12 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> This and HID_DG_STYLUS are pretty much the same thing so add suffix for
> HID_DG_PEN too. This makes the input device name look better.
>
> While doing this, remove the suffix override from hid-multitouch, as it
> is now handled by hid-input. Also, the suffix override done by
> hid-multitouch was wrong, as it mapped HID_DG_PEN => "Stylus" and
> HID_DG_STYLUS => "Pen".

FWIW, I was thinking at the following:
---
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 837585f4e673..fe0da7bf24a9 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1775,6 +1775,15 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
                         suffix = "Mouse";
                         break;
                 case HID_DG_PEN:
+                       /*
+                        * yes, there is an issue here:
+                        *  DG_PEN -> "Stylus"
+                        *  DG_STYLUS -> "Pen"
+                        * But changing this now means users with config snippets
+                        * will have to change it and the test suite will not be happy.
+                        */
+                       suffix = "Stylus";
+                       break;
                 case HID_DG_STYLUS:
                         suffix = "Pen";
                         break;
---

Because the current patch breaks the test suite.

Cheers,
Benjamin

>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  drivers/hid/hid-input.c      | 1 +
>  drivers/hid/hid-multitouch.c | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index ad718ceb8af3..78205e445652 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1741,6 +1741,7 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
>                 case HID_GD_MOUSE:
>                         suffix = "Mouse";
>                         break;
> +               case HID_DG_PEN:
>                 case HID_DG_STYLUS:
>                         suffix = "Pen";
>                         break;
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 082376a6cb3d..99eabfb4145b 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1606,9 +1606,6 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
>         case HID_DG_STYLUS:
>                 /* force BTN_STYLUS to allow tablet matching in udev */
>                 __set_bit(BTN_STYLUS, hi->input->keybit);
> -               fallthrough;
> -       case HID_DG_PEN:
> -               suffix = "Stylus";
>                 break;
>         default:
>                 suffix = "UNKNOWN";
> --
> 2.25.1
>

