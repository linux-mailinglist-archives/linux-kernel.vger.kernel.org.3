Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D7C528CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbiEPSOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344617AbiEPSN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:13:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32063DA58;
        Mon, 16 May 2022 11:13:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r30so3901629wra.13;
        Mon, 16 May 2022 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAh1w4oixfWwU61+5aeHb750MyVtmsWPesskKRuRyus=;
        b=XenR5GM9zz9ILZpsFoyQsqtGth5oABymZLDmzCHtc1N4RdZj542y36ABQkeiQl31HG
         Md7XzJitLsDB8d8MZ/AbD/TDhcddupfnPrTlmZRu0B1g1Kl6sfh99gwUMB+VVagz0w+m
         aHtRkib2cektC3V7r+ESfN6njIXaagc/Fg888+/eZ4/h7gOxkVccOsgI065pcQKu+Qa/
         VtWBxpvw0BSKfzDpwYbjl/UeOhj+fxbFLKU4AQ8hZ29lumNgY3IpPoSiuDdaYkQdCuze
         N68m7U5gyCxhwEyS21T+bP1GKzObWm8ZKc5TDv9BujxH94rhHfjpSycFEp0Wz0wBbthZ
         iZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAh1w4oixfWwU61+5aeHb750MyVtmsWPesskKRuRyus=;
        b=H7Gzmj111HrzcKXBIl3vMdXQKgGsD6umXYgsPK0H+t7Wd3XOWyUdivYXoN+E2iccCM
         O9JP7qSnwjqomVJB1/coB3NR/HNjVQONnIt5nNX9E9qMnnSSQIVMfOURKUd4HXCnY6Xd
         YOiaE056EWmAO/nsxcPy3HvlhYIo6jw9rwRJ9O3kNjhmYzWfb4vRYGuZnY/RSt/jXXNP
         yaGFckoorahfqVDzjFYFULH9Z8Zhz2BYJ7KRhUeHw+IiMyFNCqgMTjF8k79+i06+Yil/
         QMZwX89oBFF7UdSfJoK7zO8piVYT/o7Eb/qvu58fZqAWJBWPFZJAaPOs6DiIqJv+x8mr
         EOhA==
X-Gm-Message-State: AOAM531rlzFwOyf62tF+q3UO0CR0ShMEQ3kfXb+G1kHU+yuDmSg1kPJy
        V/S6Fo/l9VZIHlSHCykZrTxO5GGbQQ/6zQ==
X-Google-Smtp-Source: ABdhPJxkV8qkUufNWHnrMCLtV+2sBjdh4/rXaGuItqtHS8y6oN4/uZ/W/7/WlQndjn5rgMjPf3lV6Q==
X-Received: by 2002:adf:e187:0:b0:20d:48e:5448 with SMTP id az7-20020adfe187000000b0020d048e5448mr7129224wrb.606.1652724832171;
        Mon, 16 May 2022 11:13:52 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600002cf00b0020d0c9c95d3sm3276382wry.77.2022.05.16.11.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:13:51 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 4/4] HID: uclogic: Add support for XP-PEN Deco L
Date:   Mon, 16 May 2022 20:13:23 +0200
Message-Id: <20220516181323.59554-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516181323.59554-1-jose.exposito89@gmail.com>
References: <20220516181323.59554-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XP-PEN Deco L (UGEE) needs to be initialized by sending a buffer of
magic data, discovered by sniffing the Windows driver traffic.

In order to differentiate UGEE tablets that need this kind of
initialization from the previous ones, name them v2 internally and
create an entry point for them.

After initialization, the template report descriptors can be discovered
by parsing a string descriptor, similar to the one exposed by HUION v1
devices.

Add all the required elements to support the device.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-ids.h            |   1 +
 drivers/hid/hid-uclogic-core.c   |   2 +
 drivers/hid/hid-uclogic-params.c | 199 +++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c  | 102 ++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |   8 ++
 5 files changed, 312 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f8b3774a3a10..ea4e60de46db 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1272,6 +1272,7 @@
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G540	0x0075
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640	0x0094
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01	0x0042
+#define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L	0x0935
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06	0x0078
 #define USB_DEVICE_ID_UGEE_TABLET_G5		0x0074
 #define USB_DEVICE_ID_UGEE_TABLET_EX07S		0x0071
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index c0fe66e50c58..47a17375c7fc 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -521,6 +521,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06) },
 	{ }
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index b43142f98a8b..00090d11b413 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1002,6 +1002,199 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	return rc;
 }
 
+/**
+ * uclogic_probe_interface() - some tablets, like the Parblo A610 PLUS V2 or
+ * the XP-PEN Deco Mini 7, need to be initialized by sending them magic data.
+ *
+ * @hdev:	The HID device of the tablet interface to initialize and get
+ *		parameters from. Cannot be NULL.
+ * @magic_arr:	The magic data that should be sent to probe the interface.
+ *		Cannot be NULL.
+ * @magic_size:	Size of the magic data.
+ * @endpoint:	Endpoint where the magic data should be sent.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_probe_interface(struct hid_device *hdev, u8 *magic_arr,
+				   int magic_size, int endpoint)
+{
+	struct usb_device *udev;
+	unsigned int pipe = 0;
+	int sent;
+	u8 *buf = NULL;
+	int rc = 0;
+
+	if (!hdev || !magic_arr) {
+		rc = -EINVAL;
+		goto cleanup;
+	}
+
+	buf = kmemdup(magic_arr, magic_size, GFP_KERNEL);
+	if (!buf) {
+		rc = -ENOMEM;
+		goto cleanup;
+	}
+
+	udev = hid_to_usb_dev(hdev);
+	pipe = usb_sndintpipe(udev, endpoint);
+
+	rc = usb_interrupt_msg(udev, pipe, buf, magic_size, &sent, 1000);
+	if (rc || sent != magic_size) {
+		hid_err(hdev, "Interface probing failed: %d\n", rc);
+		rc = -1;
+		goto cleanup;
+	}
+
+	rc = 0;
+cleanup:
+	kfree(buf);
+	return rc;
+}
+
+/**
+ * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
+ * discovering their parameters.
+ *
+ * These tables, internally designed as v2 to differentiate them from older
+ * models, expect a payload of magic data in orther to be switched to the fully
+ * functional mode and expose their parameters in a similar way to the
+ * information present in uclogic_params_pen_init_v1() but with some
+ * differences.
+ *
+ * @params:	Parameters to fill in (to be cleaned with
+ *		uclogic_params_cleanup()). Not modified in case of error.
+ *		Cannot be NULL.
+ * @hdev:	The HID device of the tablet interface to initialize and get
+ *		parameters from. Cannot be NULL.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
+				       struct hid_device *hdev)
+{
+	int rc = 0;
+	struct usb_device *udev;
+	struct usb_interface *iface;
+	__u8 bInterfaceNumber;
+	const int str_desc_len = 12;
+	__u8 *str_desc = NULL;
+	__u8 *rdesc_pen = NULL;
+	__u8 *rdesc_frame = NULL;
+	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
+	s32 resolution;
+	__u8 magic_arr[] = {
+		0x02, 0xb0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+	};
+	/* The resulting parameters (noop) */
+	struct uclogic_params p = {0, };
+
+	if (!params || !hdev) {
+		rc = -EINVAL;
+		goto cleanup;
+	}
+
+	udev = hid_to_usb_dev(hdev);
+	iface = to_usb_interface(hdev->dev.parent);
+	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+	if (bInterfaceNumber != 2) {
+		uclogic_params_init_invalid(&p);
+		goto output;
+	}
+
+	/*
+	 * Initialize the interface by sending magic data.
+	 * The specific data was discovered by sniffing the Windows driver
+	 * traffic.
+	 */
+	rc = uclogic_probe_interface(hdev, magic_arr, sizeof(magic_arr), 0x03);
+	if (rc) {
+		uclogic_params_init_invalid(&p);
+		goto output;
+	}
+
+	/*
+	 * Read the string descriptor containing pen and frame parameters.
+	 * The specific string descriptor and data were discovered by sniffing
+	 * the Windows driver traffic.
+	 */
+	rc = uclogic_params_get_str_desc(&str_desc, hdev, 100, str_desc_len);
+	if (rc != str_desc_len) {
+		hid_err(hdev, "failed retrieving pen and frame parameters: %d\n", rc);
+		uclogic_params_init_invalid(&p);
+		goto output;
+	}
+
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] =
+		get_unaligned_le16(str_desc + 2);
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] =
+		get_unaligned_le16(str_desc + 4);
+	desc_params[UCLOGIC_RDESC_FRAME_PH_ID_UM] = str_desc[6];
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] =
+		get_unaligned_le16(str_desc + 8);
+	resolution = get_unaligned_le16(str_desc + 10);
+	if (resolution == 0) {
+		desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = 0;
+		desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] = 0;
+	} else {
+		desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM] =
+			desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] * 1000 /
+			resolution;
+		desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] =
+			desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] * 1000 /
+			resolution;
+	}
+	kfree(str_desc);
+	str_desc = NULL;
+
+	/* Initialize the pen interface */
+	rdesc_pen = uclogic_rdesc_template_apply(
+				uclogic_rdesc_ugee_v2_pen_template_arr,
+				uclogic_rdesc_ugee_v2_pen_template_size,
+				desc_params, ARRAY_SIZE(desc_params));
+	if (!rdesc_pen) {
+		rc = -ENOMEM;
+		goto cleanup;
+	}
+
+	p.pen.desc_ptr = rdesc_pen;
+	p.pen.desc_size = uclogic_rdesc_ugee_v2_pen_template_size;
+	p.pen.id = 0x02;
+	p.pen.subreport_list[0].value = 0xf0;
+	p.pen.subreport_list[0].id = UCLOGIC_RDESC_V1_FRAME_ID;
+
+	/* Initialize the frame interface */
+	rdesc_frame = uclogic_rdesc_template_apply(
+				uclogic_rdesc_ugee_v2_frame_btn_template_arr,
+				uclogic_rdesc_ugee_v2_frame_btn_template_size,
+				desc_params, ARRAY_SIZE(desc_params));
+	if (!rdesc_frame) {
+		rc = -ENOMEM;
+		goto cleanup;
+	}
+
+	rc = uclogic_params_frame_init_with_desc(&p.frame_list[0],
+						 rdesc_frame,
+						 uclogic_rdesc_ugee_v2_frame_btn_template_size,
+						 UCLOGIC_RDESC_V1_FRAME_ID);
+	kfree(rdesc_frame);
+	if (rc) {
+		uclogic_params_init_invalid(&p);
+		goto output;
+	}
+
+output:
+	/* Output parameters */
+	memcpy(params, &p, sizeof(*params));
+	memset(&p, 0, sizeof(p));
+	rc = 0;
+cleanup:
+	kfree(str_desc);
+	uclogic_params_cleanup(&p);
+	return rc;
+}
+
 /**
  * uclogic_params_init() - initialize a tablet interface and discover its
  * parameters.
@@ -1237,6 +1430,12 @@ int uclogic_params_init(struct uclogic_params *params,
 			uclogic_params_init_invalid(&p);
 		}
 		break;
+	case VID_PID(USB_VENDOR_ID_UGEE,
+		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L):
+		rc = uclogic_params_ugee_v2_init(&p, hdev);
+		if (rc != 0)
+			goto cleanup;
+		break;
 	case VID_PID(USB_VENDOR_ID_TRUST,
 		     USB_DEVICE_ID_TRUST_PANORA_TABLET):
 	case VID_PID(USB_VENDOR_ID_UGEE,
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index cf04e71b7bb5..c552c989976a 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -859,6 +859,108 @@ const __u8 uclogic_rdesc_v2_frame_dial_arr[] = {
 const size_t uclogic_rdesc_v2_frame_dial_size =
 			sizeof(uclogic_rdesc_v2_frame_dial_arr);
 
+/* Fixed report descriptor template for UGEE v2 pen reports */
+const __u8 uclogic_rdesc_ugee_v2_pen_template_arr[] = {
+	0x05, 0x0d,         /*  Usage Page (Digitizers),                */
+	0x09, 0x01,         /*  Usage (Digitizer),                      */
+	0xa1, 0x01,         /*  Collection (Application),               */
+	0x85, 0x02,         /*      Report ID (2),                      */
+	0x09, 0x20,         /*      Usage (Stylus),                     */
+	0xa1, 0x00,         /*      Collection (Physical),              */
+	0x09, 0x42,         /*          Usage (Tip Switch),             */
+	0x09, 0x44,         /*          Usage (Barrel Switch),          */
+	0x09, 0x46,         /*          Usage (Tablet Pick),            */
+	0x75, 0x01,         /*          Report Size (1),                */
+	0x95, 0x03,         /*          Report Count (3),               */
+	0x14,               /*          Logical Minimum (0),            */
+	0x25, 0x01,         /*          Logical Maximum (1),            */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0x95, 0x02,         /*          Report Count (2),               */
+	0x81, 0x03,         /*          Input (Constant, Variable),     */
+	0x09, 0x32,         /*          Usage (In Range),               */
+	0x95, 0x01,         /*          Report Count (1),               */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0x95, 0x02,         /*          Report Count (2),               */
+	0x81, 0x03,         /*          Input (Constant, Variable),     */
+	0x75, 0x10,         /*          Report Size (16),               */
+	0x95, 0x01,         /*          Report Count (1),               */
+	0x35, 0x00,         /*          Physical Minimum (0),           */
+	0xa4,               /*          Push,                           */
+	0x05, 0x01,         /*          Usage Page (Desktop),           */
+	0x09, 0x30,         /*          Usage (X),                      */
+	0x65, 0x13,         /*          Unit (Inch),                    */
+	0x55, 0x0d,         /*          Unit Exponent (-3),             */
+	0x27, UCLOGIC_RDESC_PEN_PH(X_LM),
+			    /*          Logical Maximum (PLACEHOLDER),  */
+	0x47, UCLOGIC_RDESC_PEN_PH(X_PM),
+			    /*          Physical Maximum (PLACEHOLDER), */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0x09, 0x31,         /*          Usage (Y),                      */
+	0x27, UCLOGIC_RDESC_PEN_PH(Y_LM),
+			    /*          Logical Maximum (PLACEHOLDER),  */
+	0x47, UCLOGIC_RDESC_PEN_PH(Y_PM),
+			    /*          Physical Maximum (PLACEHOLDER), */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0xb4,               /*          Pop,                            */
+	0x09, 0x30,         /*          Usage (Tip Pressure),           */
+	0x45, 0x00,         /*          Physical Maximum (0),           */
+	0x27, UCLOGIC_RDESC_PEN_PH(PRESSURE_LM),
+			    /*          Logical Maximum (PLACEHOLDER),  */
+	0x75, 0x0D,         /*          Report Size (13),               */
+	0x95, 0x01,         /*          Report Count (1),               */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0x75, 0x01,         /*          Report Size (1),                */
+	0x95, 0x03,         /*          Report Count (3),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0x09, 0x3d,         /*          Usage (X Tilt),                 */
+	0x35, 0xC3,         /*          Physical Minimum (-61),         */
+	0x45, 0x3C,         /*          Physical Maximum (60),          */
+	0x15, 0xC3,         /*          Logical Minimum (-61),          */
+	0x25, 0x3C,         /*          Logical Maximum (60),           */
+	0x75, 0x08,         /*          Report Size (8),                */
+	0x95, 0x01,         /*          Report Count (1),               */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0x09, 0x3e,         /*          Usage (Y Tilt),                 */
+	0x35, 0xC3,         /*          Physical Minimum (-61),         */
+	0x45, 0x3C,         /*          Physical Maximum (60),          */
+	0x15, 0xC3,         /*          Logical Minimum (-61),          */
+	0x25, 0x3C,         /*          Logical Maximum (60),           */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0xc0,               /*      End Collection,                     */
+	0xc0,               /*  End Collection                          */
+};
+const size_t uclogic_rdesc_ugee_v2_pen_template_size =
+			sizeof(uclogic_rdesc_ugee_v2_pen_template_arr);
+
+/* Fixed report descriptor template for UGEE v2 frame reports (buttons only) */
+const __u8 uclogic_rdesc_ugee_v2_frame_btn_template_arr[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),                   */
+	0x09, 0x07,         /*  Usage (Keypad),                         */
+	0xA1, 0x01,         /*  Collection (Application),               */
+	0x85, UCLOGIC_RDESC_V1_FRAME_ID,
+			    /*      Report ID,                          */
+	0x05, 0x0D,         /*      Usage Page (Digitizer),             */
+	0x09, 0x39,         /*      Usage (Tablet Function Keys),       */
+	0xA0,               /*      Collection (Physical),              */
+	0x75, 0x01,         /*          Report Size (1),                */
+	0x95, 0x08,         /*          Report Count (8),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0x05, 0x09,         /*          Usage Page (Button),            */
+	0x19, 0x01,         /*          Usage Minimum (01h),            */
+	UCLOGIC_RDESC_FRAME_PH_BTN,
+			    /*          Usage Maximum (PLACEHOLDER),    */
+	0x95, 0x0A,         /*          Report Count (10),              */
+	0x14,               /*          Logical Minimum (0),            */
+	0x25, 0x01,         /*          Logical Maximum (1),            */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0x95, 0x46,         /*          Report Count (70),              */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0xC0,               /*      End Collection,                     */
+	0xC0                /*  End Collection                          */
+};
+const size_t uclogic_rdesc_ugee_v2_frame_btn_template_size =
+			sizeof(uclogic_rdesc_ugee_v2_frame_btn_template_arr);
+
 /* Fixed report descriptor for Ugee EX07 frame */
 const __u8 uclogic_rdesc_ugee_ex07_frame_arr[] = {
 	0x05, 0x01,             /*  Usage Page (Desktop),                   */
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 3d78299f082d..86e64a9ee6bd 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -161,6 +161,14 @@ extern const size_t uclogic_rdesc_v2_frame_dial_size;
 /* Device ID byte offset in v2 frame dial reports */
 #define UCLOGIC_RDESC_V2_FRAME_DIAL_DEV_ID_BYTE	0x4
 
+/* Fixed report descriptor template for UGEE v2 pen reports */
+extern const __u8 uclogic_rdesc_ugee_v2_pen_template_arr[];
+extern const size_t uclogic_rdesc_ugee_v2_pen_template_size;
+
+/* Fixed report descriptor template for UGEE v2 frame reports (buttons only) */
+extern const __u8 uclogic_rdesc_ugee_v2_frame_btn_template_arr[];
+extern const size_t uclogic_rdesc_ugee_v2_frame_btn_template_size;
+
 /* Fixed report descriptor for Ugee EX07 frame */
 extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
 extern const size_t uclogic_rdesc_ugee_ex07_frame_size;
-- 
2.25.1

