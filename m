Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37113509BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387051AbiDUJCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387152AbiDUJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECD1821E13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650531515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUZ/9nACQvIMuURhPtWbiiAz5sNLXuCG0brhweSfYh4=;
        b=enxIyrimtepXUJMwm7R4TxH38RUc81GyIyU8fmsdEjakQmGWgZ0csQHs8jCPpmYX/zYgrQ
        WvhRl2k0+Y6IArotX+go5woiUqpiCHIhIYDy/2S03lbnbKhxw/FPz8b2zLmikgJrU9LxN2
        sj00Yzia2qFH2EBeH8drxunpPmaj78o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-YGUoWOAoNzyxhKXdX6vv9A-1; Thu, 21 Apr 2022 04:58:31 -0400
X-MC-Unique: YGUoWOAoNzyxhKXdX6vv9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3359A8038E3;
        Thu, 21 Apr 2022 08:58:31 +0000 (UTC)
Received: from [10.39.194.205] (unknown [10.39.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5285B145BA6F;
        Thu, 21 Apr 2022 08:58:30 +0000 (UTC)
Message-ID: <78d86949-f2b0-23a6-3438-fc2a3894da7a@redhat.com>
Date:   Thu, 21 Apr 2022 10:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] hid: multitouch: improve custom quirks kernel
 parameter
To:     Tao Jin <tao-j@outlook.com>
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        linux-kernel@vger.kernel.org, Tao Jin <tao-j@outlook.com>
References: <20220418031827.37423-1-tao-j@outlook.com>
 <CO6PR03MB62415B5977AF75C5B753E73CE1F39@CO6PR03MB6241.namprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CO6PR03MB62415B5977AF75C5B753E73CE1F39@CO6PR03MB6241.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Apr 18, 2022 at 5:19 AM Tao Jin <tao-j@outlook.com> wrote:
>
> This allows a list of different quirks to be matched against
> corresponding hardware ids in case there are multiple devices present on
> the same system.
>
> The code borrowed some idea from vfio_pci.c

I am not completely against such a parameter, but this raises a couple
of pain points:
- we are now adding string parsing in the module. I know this is
something somewhat common for dynamic quirks, but still, that is
potential code to maintain and ensure it doesn't do anything wrong
- how are we going to force people to contribute to the upstream kernel
to fix their device for anybody, not just them? Users might be tempted
to just drop the udev rule and then forget about it.

(foreword: I am deeply convinced BPF is the future, and sees nails
everywhere given that wonderful hammer).

I am trying really hard to stop creating new kernel APIs for HID. One
solution is to use BPF.

This would solve the first point, given that instead of providing a
string, we would request users to provide a BPF program, which would be
verified by the BPF verifier.
This would also add a slighter difficulty to address the second point as
writing the BPF program would be more "difficult" than running a script.

I don't have a complete working solution here, but basically the kernel
patch would be:

---
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 99eabfb4145b..b0d187e5fe70 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1695,9 +1695,15 @@ static void mt_expired_timeout(struct timer_list *t)
  	clear_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
  }
  
+__weak noinline int mt_override_quirks(const struct hid_device_id *id)
+{
+	return 0;
+}
+ALLOW_ERROR_INJECTION(mt_override_quirks, ERRNO);
+
  static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
  {
-	int ret, i;
+	int ret, i, override_quirks;
  	struct mt_device *td;
  	const struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
  
@@ -1746,6 +1752,10 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
  
  	timer_setup(&td->release_timer, mt_expired_timeout, 0);
  
+	override_quirks = mt_override_quirks(id);
+	if (override_quirks)
+		td->mtclass.quirks = override_quirks;
+
  	ret = hid_parse(hdev);
  	if (ret != 0)
  		return ret;

---

And then the BPF program can match against `id` fields and decide to
return or not a new quirk override.

>
> Signed-off-by: Tao Jin <tao-j@outlook.com>
> ---
>  drivers/hid/hid-multitouch.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index c6d64f8..f662960 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -398,9 +398,9 @@ static const struct mt_class mt_classes[] = {
>         { }
>  };
>
> -static int override_quirks = -1;
> -module_param(override_quirks, int, 0444);
> -MODULE_PARM_DESC(override_quirks, "Signed integer to override quirks in mtclass, must >= 0 to enable override.");
> +static char override_quirks[128] = "";
> +module_param_string(override_quirks, override_quirks, sizeof(override_quirks), 0444);
> +MODULE_PARM_DESC(override_quirks, "List of quirks and corresponding device ids in hex to override quirks, format is \"wanted_quirks:vendor:product\", multiple comma separated entries can be specified.");

The previous patch added this module parameter, and now this one changes
entirely its API. We better squash the inclusion of the new module
parameter into this commit so we don't have 2 APIs for the same module
parameter.

Also, for the format, we probably want
"bus:vendor:product:group:wanted_quirks", where bus and group can be
replaced by * if we don't care about them.

>
>  static ssize_t mt_show_quirks(struct device *dev,
>                            struct device_attribute *attr,
> @@ -1714,6 +1714,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         int ret, i;
>         struct mt_device *td;
>         const struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
> +       char *p, *qk;
>
>         for (i = 0; mt_classes[i].name ; i++) {
>                 if (id->driver_data == mt_classes[i].name) {
> @@ -1753,9 +1754,28 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         if (id->group != HID_GROUP_MULTITOUCH_WIN_8)
>                 hdev->quirks |= HID_QUIRK_MULTI_INPUT;
>
> -       if (override_quirks >= 0) {
> -               hid_info(hdev, "overriding quirks with: %d(0x%x)", override_quirks, override_quirks);
> -               td->mtclass.quirks = override_quirks;
> +       p = override_quirks;
> +       while ((qk = strsep(&p, ","))) {
> +               __u32 wanted_quirks = 0;
> +               __u32 vendor, product = HID_ANY_ID;
> +               int fields;
> +
> +               if (!strlen(qk))
> +                       continue;
> +
> +               fields = sscanf(qk, "%x:%x:%x", &wanted_quirks,
> +                               &vendor, &product);
> +
> +               if (fields != 3) {
> +                       continue;
> +               }
> +
> +               if (id->vendor == vendor && id->product == product) {
> +                       hid_info(hdev, "overriding quirks of %04x:%04x with: %x",
> +                                       id->vendor, id->product, wanted_quirks);
> +                       td->mtclass.quirks = wanted_quirks;
> +                       break;
> +               }

This should definitely be extracted in a separate function.

Cheers,
Benjamin

>         }
>
>         if (td->mtclass.quirks & MT_QUIRK_FORCE_MULTI_INPUT) {
> --
> 2.35.1
>

