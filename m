Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7DF504B40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiDRDVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiDRDVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:21:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2103.outbound.protection.outlook.com [40.92.21.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149216582;
        Sun, 17 Apr 2022 20:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrLsN3MWOZr5/vLDEIVwP4EIuVaNR3M8gTdHVPuXajam1jqT277D849vegg3OS5XX2ZnCIlZN4KAohm1oG18PY2yTH8+HDoY6zRIW+UH+F+aVG1gr8dQ5Tg3FK5YAoloHhyF5sZ69NIQai4UCEGq/gCv+Nt8QlSxAJtdyoae7Fuiqsz4Iig+3VXE4zSry1ZnvUFuWf0rW8/x4BOq0tuqBqCHc+g7lxpN5kMS1s00OdO2n4ynsxYUNUf/n2++2HP4Hf6LTk2frd+8sCLd+avrX6oYka/pUgpQvMu2ZbAAamtPhA3KnggI0du7U7iqr3BJYbuysMXrrCF2FxZVe8WRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8WCTicGLayYERIxGpDQeZrTPt8Gw748nN3kbAp3l54=;
 b=Wofg8JVWqy0QJM/ky4jFzersQpYGVcLo4vazbk2gfbVMQTkrYXG9cAr1VKJbF/2PlQD5WSu7ZFwUSWL3GWmuFl9KJDIxa1/XtR0vgTmJMwGkBe9WvZOGr9bwtdrg2F2xO0R5oMj+3xW6afNwjpUhnGApd1GBZ03pNuo9aMhSk1fo0eOCr/3HR6Pll5OmImO2/Dul2S+AG8NhE+CiUzAb+7OLCqhvGqPwbPynNyWE31tRtHlfnGAC6AMl1xutrWLt3YhGnFLK/1CdD/Ho8ggtcoL29LDjcjLjDscIYjfdDoIGsljuv+0X5v2/Q3VUGKdVdv+UnDPqXgE7ZgWHvq/6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8WCTicGLayYERIxGpDQeZrTPt8Gw748nN3kbAp3l54=;
 b=ZN0ive7J/1J2noa9bjDOpsNkB3kb+ue3JYXtrUmfwSJliq76INHjNJDSLKfrJGE0YQi9dRcw/Fg2WSa4PNixVy46Y6E2DTQF0vO1YGlTKiP1IswJcgrkAx/FJOKv+lxP2DWBvqsPjW5NJnDLgiLvaqdoBmsQGLV7VhqHSl7imk455ToJU4tBh4vk8y0qJBLjEeT6Oh/GocAiVgoonpb891QC8PtOfU8EvG2npSl5EqnwA0pYBavkvwzExuUkzOhihpyesewOTxwx7uTPIYNcL8GdJ8ey1PCUJnvSy/5WH7hFANKiHCXmCBW134Jh5/IJjSj3LH44sggGriOvp3Ge/w==
Received: from CO6PR03MB6241.namprd03.prod.outlook.com (2603:10b6:303:13b::6)
 by BN6PR03MB2803.namprd03.prod.outlook.com (2603:10b6:404:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 03:18:43 +0000
Received: from CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::98cd:da57:6117:c992]) by CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::98cd:da57:6117:c992%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 03:18:43 +0000
From:   Tao Jin <tao-j@outlook.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        Tao Jin <tao-j@outlook.com>,
        Bingchen Gong <gongbingchen@gmail.com>
Subject: [PATCH 1/2] hid: multitouch: add module paramter to override quirks
Date:   Sun, 17 Apr 2022 23:18:26 -0400
Message-ID: <CO6PR03MB6241819B3312BAD5A4DDE332E1F39@CO6PR03MB6241.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [XfL+OE5JIM+plyKNcGUvsa4uZFHvBEGO]
X-ClientProxiedBy: MN2PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:160::35) To CO6PR03MB6241.namprd03.prod.outlook.com
 (2603:10b6:303:13b::6)
X-Microsoft-Original-Message-ID: <20220418031827.37423-1-tao-j@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 517ae5d8-bc90-4a42-cd8d-08da20ea246e
X-MS-Exchange-SLBlob-MailProps: CaK+F7me6Ck/FTX4x064BW1Pg6/6QSqD5HgsgrGrHJUBI60lcMGiC+cNFOVSecvhWrLYCK4a2xDubAdUNzEijFHeH2uhumAkojUErgA5va2jwFv+2zsVMiKkI8pQ6FuOmvG4YVEMywbEDtuIyZBR0hxIqMc1XvsmJCwPV6vXUkY6aReB6koaoWOAvr52kG92o/3W6GM3v9BrZLryM/fv2aLOxNeQ0ayJ3bxowP25im9ViKEq+/GjLUVEDjpb0PCbAAtBliZn0xG6b7xtiXSspbr6/FHoLcEBjnPfrCJcAqYjjVFg1sU/sDfyRr1hwkrxRN9VIrxdZ4K6ZfDq+hThAnLITonaTOK2fk30t+tDpJ7zxOu/kCeVUocO8S+hO/Fc6YOZDv8XU/bEuLHQqlmRPPHt0zsWhdutU9Gfb5gqAwTnfJgfF/QVGgTT9StgpzW3l1bsdF+K3vLwf2GIzWISP9+OnugM+4AFrn8ShM90BNHUjbU1133fJZ7NtpRcBwz4clVSK3Tu37bfQJXEsJEl1NgOwVvNugWEWuBmq8Mqc+b67q6EprKicPYKCiCC+T/qHqM9GI1HWSA2WtenJiduafZr8ZVSnxZ75WiPUpG5hHNejsLbxCfJXx8sRGq4MxNMd9P8MOftNyXVTEBd8dddDtPklpswNZWqSmRDRqCN5qjM+qk6JmjOaEc79CDR0Cl33XuOt8AKzwZ4oeA5lxwixFjG6zT6rhsObvESQ/f9ekmypdofYoeUrQ==
X-MS-TrafficTypeDiagnostic: BN6PR03MB2803:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmYVAqq12Hf92psco076VGRji+QZlihTBlwRxyhRvGkbIJVWs4Iv532pUg8rLyU5vTzic0WyVpbSpsLNZbu49RKIEEXH5vWP2Lo4VCN+ZNsXcuhkTDH39CkyRba9o/IPUYGpk4tMBmEqMsp9jt+/SaU2q9o3OnhtsqbdTxFpovSJUbEOqEqGOsMoaz1CT8iih8axk+Ki7eVCaGU+q9DOy/zSM6jCh9v3qssQ5pvWsr4xnM7d0O2HFEYEcN0SMIU93WYR4SE1qfP26CRBvezkcAtiBsxN7IEoFtA8/D67iyCbVOLolBeR8laaqXIA7cCw+k9lTv5GiorAD4R7f1Gfnt5aVfcvmL5RJeJLrzBHZdS89YakpJssJgTbuwv4IYC9EoAH9T46LQwsKLggqjtlOwVkimFbswV/RxlHlnBGsi7Prti+ZoMEdGKvj854VTrnddvW1DXBqdohohk90+fwJq0loGLmabLjZfEdxov5XZAxs0zzjZe7oSLRSF+o3qZ0gEZhF8uNb3PjQ415486xmST1Xrck4A9VVTU65p9fvKC4FTk5/vnwlm22Ei3uSzairHVMYmnUjdwwFxRhGJussQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o28A5jocBv/o+QhdEo/KPjbMxa09X/a19Y71r3i810xOCsd6bGDaL6NLRGEz?=
 =?us-ascii?Q?no7CMSq3q/HFB4ZlzYQt4gTIGWT6fxE5ZV+RTuIhT3ZLdNEStE0OV+JXgFXP?=
 =?us-ascii?Q?j/CIL0p2mJc/dHXkPCDlshUgyXriM/DME1xE/obzyOziq0mHuIuaDdgWL83B?=
 =?us-ascii?Q?6Gc1dlrANF2cLErQJdWR7g+2yE83kiayUMm2CBxrLSPT7paDLHg/s0P8bZNr?=
 =?us-ascii?Q?Wn6nhyJIUNOSJAP5+nGOTSBSaQuqu1qN/8BpJ+6QY2nxqcNS8NUJiDm+CHzY?=
 =?us-ascii?Q?sQnWsS62IHQ5KrFlIZ9jDRBslHxxYTPoLVuTX0CEfgUcZ5bGHxQ4WZd/D+ER?=
 =?us-ascii?Q?bGQd9ZdbpG/8HsMnqmgJnM216/9l5R97GB6Fic+i0x463lOKbHrdWFXYJGf0?=
 =?us-ascii?Q?ClDiBupqBtMt3rbW325wehQWtMDHDv87oaGkMtcxi87SjyEIVcpwS1WIN5Wh?=
 =?us-ascii?Q?xlJ2bvuxsdEZ+slC6TCjJKpG/48asucv+3AUfen8puJMq4HYky0pEsAqUL33?=
 =?us-ascii?Q?ZpwppIgs0nmG1BE1msZrQenSSNyUfh4aeE//ALtozNORPEsoxkeViwwY8ffv?=
 =?us-ascii?Q?7LTxHAYNVl0s8Pwmt8z9anU+qgLalu7XI7rTZTgdYb4kd+Wzx6l5h71h920y?=
 =?us-ascii?Q?Iry48LvBPew8FkkgwkcXz48gRhN5p8CjmM6a3Ay5lFB8QkRKj+Tb6AnupsIw?=
 =?us-ascii?Q?9+m6FxX+pL7QesdIKiQ7DqoHIePsJ3Ks/CEgWxYtihV5fsfFPSQ6ocz/tAP8?=
 =?us-ascii?Q?os+g7dZRpSAdATesjpp/6xIEv1gW+/KL5Hg1RJ59Lw2QvXM8Y2EgYAm3v5yc?=
 =?us-ascii?Q?nurOUDE2VJi+OSwY+oPcnJyKq3XU4XBwLfbifdHdHHTSQpo8O9f+f5dp0puj?=
 =?us-ascii?Q?00tkLNjwrYmVIoq7JHT/gD5iJLhHD7UIO/s2acRpjw99somn6y0Nb+8IysA8?=
 =?us-ascii?Q?wRsDW4ta24x9RoKzS7YhiIf6fPEUPhP21fuLX1AhMsxxlSY40SoOY0pR5N0i?=
 =?us-ascii?Q?BrCmWJqFJHBSYzLH9xwRaAiAF3MfbkOfW2yD0AMLr0ZbxLxaZ62+m5rodBIV?=
 =?us-ascii?Q?3sFumEHIhhGxa8JEE5kCbdMU7TNiyT3PtP5kf7ifvg2uZPSKWLQmwmlpi3VV?=
 =?us-ascii?Q?Ny4isrOfERNgurj7k2uNBIcqcVKdbM3d/TU1C6jwi0nvIL1XqxpSMcgCAEgP?=
 =?us-ascii?Q?/uUgHU0sH6RzaupCVrDBwuvCkcXG97OoJvv0ndWHOTx2aNduY2dvTOU8Z0Lh?=
 =?us-ascii?Q?P3CK+4ydICx+uYzca1tJxs6W0qdfP28LmJFE8tSVrxEf7p5WKhb3RUwtV5Ks?=
 =?us-ascii?Q?onACtt1lAMNRclDWQP8eZXGD2ariiRdG86/C94Cr7v/YXogbDCOZltSt25rX?=
 =?us-ascii?Q?3pXgffGTYtMDeNvRLIiICI3+8C5/4Y/bex0ior//GZwphpLyaVEJrxzIqFQT?=
 =?us-ascii?Q?Aw9hRdzoDgY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517ae5d8-bc90-4a42-cd8d-08da20ea246e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR03MB6241.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 03:18:43.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2803
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a sysfs interface to specify the quirks. However, some
quirk bits such as HID_QUIRK_MULTI_INPUT are only read once during
init/probe. Setting the quirks in sysfs does not make any change to the
behaviors related to those bits. Also, it is hard to wait for udev to
modify the quirks in case there is a rule given the current init and
state machine structure.

A simple kernel paramter is provided so that any time a custom quirk
needs to be tested can be easily applied. This enables the users to test
out which bits are indeed necessary with just a rmmod then
insmod/modprobe cycle. Thus, new hardware support can be added very
soon and unneccsary mildly costly quirks using mutex and timer can also
be removed based on user's self-test.

Co-Developed-by: Bingchen Gong <gongbingchen@gmail.com>
Signed-off-by: Bingchen Gong <gongbingchen@gmail.com>
Signed-off-by: Tao Jin <tao-j@outlook.com>
---
 drivers/hid/hid-multitouch.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3ea57f3..c6d64f8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -398,6 +398,10 @@ static const struct mt_class mt_classes[] = {
 	{ }
 };
 
+static int override_quirks = -1;
+module_param(override_quirks, int, 0444);
+MODULE_PARM_DESC(override_quirks, "Signed integer to override quirks in mtclass, must >= 0 to enable override.");
+
 static ssize_t mt_show_quirks(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
@@ -1749,7 +1753,12 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (id->group != HID_GROUP_MULTITOUCH_WIN_8)
 		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
 
-	if (mtclass->quirks & MT_QUIRK_FORCE_MULTI_INPUT) {
+	if (override_quirks >= 0) {
+		hid_info(hdev, "overriding quirks with: %d(0x%x)", override_quirks, override_quirks);
+		td->mtclass.quirks = override_quirks;
+	}
+
+	if (td->mtclass.quirks & MT_QUIRK_FORCE_MULTI_INPUT) {
 		hdev->quirks &= ~HID_QUIRK_INPUT_PER_APP;
 		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
	}
@@ -1760,7 +1769,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret != 0)
 		return ret;
 
-	if (mtclass->quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
+	if (td->mtclass.quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
 		mt_fix_const_fields(hdev, HID_DG_CONTACTID);
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-- 
2.35.1

