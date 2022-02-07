Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE14AB651
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiBGHt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbiBGHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:47:22 -0500
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:47:20 PST
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3707C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644220038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1+HZbSM2dItKwztAzlpbiDWHRe2tHjMxRwCxBvZmn8E=;
        b=lw8m/wV+7Udfm+6YLNBzkpNXoYUR4v6JdvpAgFN2Sw4cUkBAn2uOaStQBAP2ymKgZfvUKd
        610pujfnzI4ImGuEUBlYXjgkw4lN5zieynMTDQRchYyJEbi3Q4zeJfUSM3MTjayjM5Z6Ud
        S+Eqnuua6PvQlxGiuecLxqf9D46/Pbw=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-o1nknDzdPx2swUU95rTgbw-1; Mon, 07 Feb 2022 08:41:06 +0100
X-MC-Unique: o1nknDzdPx2swUU95rTgbw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5it5mG5GmhPobwXX09dJe38scO/cySnSyBJz1kXP/uUcnrq6w2pJlay9WvSil3+Q/3wZGyeSuYhOQnoo8BF/K/cjHqI/bbzbRwD0i2AP6cICzBJCH/qvMsYeJpKl1W8yTOkaS1U7FcvtLnVG9vyM0shlcuv8rniRT5Tlhcbjpsfu/2LduxGmqZz36wzGLyhu30JumclGCtOKyTx6XVtbMBeLwwHJSx1hlBcc4PX4vyqlCzz4L4si23iTKZPgbt+9ulBgSMIyYgBGr8yERaKu2V4kIrPih9Pic44l1FejAX4xb/PPq8UIyHtiek2dq5MXgBnjXF0BgFjB62Kx31XZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+HZbSM2dItKwztAzlpbiDWHRe2tHjMxRwCxBvZmn8E=;
 b=ZOlVrvdGzjmBVsGE0ZyoX7odu3oM11wcG2clwxSezbc6cLVW+vQY0Yd5Vj9UfkZaXIEH7uVnu3fGFwb5qUFqSpxvQhcCrWVP1Ob50mnqfPP19d0mEngEoQ6qt1smRyS69IEiYdQSpJAcxa2ExjN1wpsEhpxj2f3qQyAHu+PIK+beOxc+YlpC3LKbOi54pujBcZnHWzx6KGQyzyoeuBHxXCeZC5I/OT8wzVG1iynOc3AHTPJpwkb+B+o3OzD0caYtOkxY2a7sjXPon6qfoWbPCzG150V+jESBu/GTBfdhQeFXbuNfJuiSNPbam7iYM/3FJAiDVMxB5tv6crLu/Y6HHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by DBAPR04MB7272.eurprd04.prod.outlook.com (2603:10a6:10:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 07:41:02 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::5160:9fd7:9627:cb11]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::5160:9fd7:9627:cb11%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 07:41:02 +0000
Message-ID: <2501ce9d-40e5-b49d-b0e5-435544d17d4a@suse.com>
Date:   Mon, 7 Feb 2022 08:41:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] xen/x86: obtain full video frame buffer address for Dom0 also
 under EFI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::25) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae4e898-5a66-4465-c815-08d9ea0d30f2
X-MS-TrafficTypeDiagnostic: DBAPR04MB7272:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DBAPR04MB7272CE5CB13BA1526B8F972DB32C9@DBAPR04MB7272.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDzK7V5BMfvIo8Q4ZUZ33BLd9FMXwa8iXwDl3suz0KT04KO5GroZynYttX3ymtzb023XoyFrZsUfa/e+k/GbmFiqE3evaDzgM4N9gl4Ep5dl6Rw7D4Zvlh+dtVQfV2VvlyFJCY2vCc8MZ3u8w3sAwmctgt1L9N97I9T5ZvO+2j93bR+vJqYfQah0/hYOhnazIW89dd7c7WTmXLkIC5wUK+kP33kfKBbUnoas+qoqVLG28Z1kumha4T7GKgEDHLUWGgQT01/WJlPorMrNI1B90O3KNTAF8wUVe8IdWek309wBFfKNr89sWbahV6wFk7h12YenXZXZZ/5kqwOg6GbyD/3OYOO9t6+Os8GeiQlkh1mvAg6yQcRMTTLhdwTgKlmDehkztaBVLR7UvkkeWTXksEVTqnoTz9EqhnoQof9WGoaAbHoVbrpRVZer2jpQLqPFFtiqBmOQ5oKOrD664aNito7+pG3VaPO3/Nt2OfhKim1Arb3vuB6yRK5l+DBV/3dMX/HLKeywvclV8JJCQbDaSrncDvglJ9MII2xBHuGBu8d12mkmIYKQg/vzpxHd4P8CQtyWPfVFMy/CiJ/vKzsV+3PHLHidh4+h1asLUrgr5MFKQ5phsZ/yF1RELcHLZ5r3TwhqBE8cBII5cJXQTDIh3VJ7OXl4ZoFK4vwSMdjpblQ6C78SeP+VRaCVHNIcoDgGM/zmRyL+KF4z0TvzGWLkfwQ7CBzvH5s9HHLrdiolYFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(316002)(38100700002)(6486002)(2616005)(4326008)(54906003)(110136005)(86362001)(5660300002)(31696002)(31686004)(36756003)(6512007)(66946007)(8936002)(83380400001)(8676002)(6506007)(26005)(186003)(66556008)(66476007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHl1b2szVDAzZkVVbWc4RHM4M1VtMUZxYVVTRUZIU0wzTTFWQjlXc3RWOWhy?=
 =?utf-8?B?bnR1aVNWdmw1V1lDRnppMlFzdUJTcFVRTWhEb3JkQzhUWXdxejdtcDFqM0hn?=
 =?utf-8?B?elNGRUxSWlA2a3dhbXlzM2xaaDRxdTRtYTBSN2N6TDRZTXdGbVBiOEVXclN5?=
 =?utf-8?B?M3lZNjd1ZmoxM3hLeEluYkFoNXdmK1BYNHJBRFE3emR4b0w4Q2tDYitUTWth?=
 =?utf-8?B?QXRjbzJhREZ2Z1Vnc05CMTl4SUwyQXdubjZCeDc3cXRZc1BJT01uTzNzcmR2?=
 =?utf-8?B?ZmVuRkRzbEpvNUVLV0s3Q3U4QWhGL2gxYmdsZ0V0Y1FqcUhGZ2tpVmh0c2to?=
 =?utf-8?B?d2RteWE2MzVGMkFxczJoSWR4VTNKdjh1TXdGamRRRXdLNGk1dDhTRDhxQXh6?=
 =?utf-8?B?Ni9zYTJYbHNOZVBwMXhIcG5wMTc3NVJkNkJwWWpYS1VyMFZ3ckphM1JOQVpQ?=
 =?utf-8?B?WU1sbWJMVGg1QkJqdWtCMWxvbS9zY21IdmliZTRLY3I5RGxXcGFIRG5EV1gz?=
 =?utf-8?B?V1hVbG56RUpNYzh6L25rMm1JbGlxVUlyb0lvS05sejBxeDE0aW9zY2lXdVdR?=
 =?utf-8?B?Q1Z3N3ltVXRyUVVIbkNOdjNCbUp4TmlZVG95U0lsTGl2QUs5V2VkVm5oR1Fr?=
 =?utf-8?B?dS8rci9nV2dCNWt0K2xhdUIwR1pSTi85STdnbFRNdHIzMHFFdjdqYWFYMEJ1?=
 =?utf-8?B?ZVNyd0s4QzNDbkhPL1NIMEJ0K3YrK0FQOUJ2YVdleDR3aXM3b28vTTV4amtK?=
 =?utf-8?B?RTgyblBsZnF1NzFMNHM4eFpEKzU5UWNYK0JlWSszbTB3SXNXVmwrRzNPOVh3?=
 =?utf-8?B?V3MxVTQxMndMNFpFc2NLZ0t5RVRYcUlCZ1F2dU9ubmI1Z1o4ZVhQVFcvQXdw?=
 =?utf-8?B?TjM3SExGRkhSL090aFUxNFpGWlZVcGVZcnpUTTJteHdqT0RwYzZFaEhLTk1P?=
 =?utf-8?B?bDJUWjBKdUgwaTl6cWJ5UVh5UmFXVy9SRFpaY0g2aFNuUDB6Z3hqdVhEUnh4?=
 =?utf-8?B?RWsvUU9XUkJFY0orOEM2RmdaWkt6Tm5OQTlCWlVXaGRkT2swcURNU1hhL0dE?=
 =?utf-8?B?bnQ4RUtUOFBublgyeUV2WnU2bzdBSzFQb3VKYWZHa0p4TktJUUM1VFFEOXlE?=
 =?utf-8?B?b2pHUEkzenpVNm0zOWk3d1hyQkVzWFRoZkpsMTJPU2tpay9saDlOcXJ4ZXRD?=
 =?utf-8?B?REc0K201VWV4Rmx0RnFIY1E2Vy9TWGRDb2V5TGdaY3hnRUNIZjRZSVE0UVNW?=
 =?utf-8?B?S2psWjZqWUI5WDB2SS9WQzlnL0FFV0d0cDVDYTUvQ05YeVlrVjhIZGJ0VDAx?=
 =?utf-8?B?WHl1elBGNk1DSFVFcmQySGVZMFc1VWg5ZFM3c0h4QjExZi9GVndUSm0wZUgz?=
 =?utf-8?B?UTZLWlQwQUtsdFczSnNPMnErM1l3Q1oreElFY25YVTlCR0hQeHFQVzRoUzF0?=
 =?utf-8?B?eFhLOFhDK1NVam1IalZnSkhGbU9FQVR2S0VhSHdGUlZDZjJYc2k2NCtJai9J?=
 =?utf-8?B?R2hReWJsMWdHdkVESjYyamtmaXRvNjdWNXdrdGU0UDVpQU9YdG5zVDFlbk90?=
 =?utf-8?B?WXFvaXdQazhLUzdZVUhSS0Ywak02TzdzZjFjeGlUWVY3UnNETGpzM3Q0dDNU?=
 =?utf-8?B?QXJQYW1yUXQ2ZHNLKyt3MkVseUtRMzhsMnV5VTdhL1B1UDRTUkFJM1NxV1hh?=
 =?utf-8?B?NVFzVlAraW5uaTB1SWJHV2hnTjNhaWoyR0JSSVYwNWZ4cjUwUGYvOUpad2Fi?=
 =?utf-8?B?cDd0NHU3WVk0SkVZTWZ0SXdSb1I0OHl1WkFtNmczMGIvNkVBSnVmbGs2Qnhx?=
 =?utf-8?B?aTRMTThqMlp3YU9OcXR3RENEMjM5YlFwOVIvNlpwa1RhRWw3MjFlUkdTaDF2?=
 =?utf-8?B?K0ZLZDdzUGhtNVUzU3dBOWUvMFdBeDVibUlReENHWDQzOGxWN2hkVXVibzJt?=
 =?utf-8?B?ZDdjQk5QMFB1cUFjOW10N0Z6UG9CdFJ6a0RqMjgyVDJ4a05RNTEwbHpZOVZM?=
 =?utf-8?B?cStZRUt6TFFhZ2U4MjlCRXNCYzIxc1htN2RrK3BuSEV4cTd0TnpIYzQyL0c3?=
 =?utf-8?B?KzF1YUtlYWkyUkpReVFvL3J5NHY5c2hUT3VOVWlLdTBNU3NUQ0ZjWE96YmNi?=
 =?utf-8?B?V0IwN0llak5WTHVyVE1oN1djcFg3N1F5OS9ROTJVM2pTbEVlOSs1a0FVUC8y?=
 =?utf-8?Q?ikIL2VDe0j2qNe2Dv+Q6JWc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae4e898-5a66-4465-c815-08d9ea0d30f2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 07:41:02.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRzZYyJ017p5qHhZ9YPyvR0wFBlqc8KfwWwnUB43f0pbFyi89GmbMxKnlnhy2Box7tr/sG1cwQjth0UvpLtzcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7272
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial change would not work when Xen was booted from EFI: There is
an early exit from the case block in that case. Move the necessary code
ahead of that.

Fixes: 335e4dd67b48 ("xen/x86: obtain upper 32 bits of video frame buffer address for Dom0")
Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/arch/x86/xen/vga.c
+++ b/arch/x86/xen/vga.c
@@ -57,6 +57,14 @@ void __init xen_init_vga(const struct do
 		screen_info->rsvd_size = info->u.vesa_lfb.rsvd_size;
 		screen_info->rsvd_pos = info->u.vesa_lfb.rsvd_pos;
 
+		if (size >= offsetof(struct dom0_vga_console_info,
+				     u.vesa_lfb.ext_lfb_base)
+		    + sizeof(info->u.vesa_lfb.ext_lfb_base)
+		    && info->u.vesa_lfb.ext_lfb_base) {
+			screen_info->ext_lfb_base = info->u.vesa_lfb.ext_lfb_base;
+			screen_info->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
+		}
+
 		if (info->video_type == XEN_VGATYPE_EFI_LFB) {
 			screen_info->orig_video_isVGA = VIDEO_TYPE_EFI;
 			break;
@@ -66,14 +74,6 @@ void __init xen_init_vga(const struct do
 				     u.vesa_lfb.mode_attrs)
 		    + sizeof(info->u.vesa_lfb.mode_attrs))
 			screen_info->vesa_attributes = info->u.vesa_lfb.mode_attrs;
-
-		if (size >= offsetof(struct dom0_vga_console_info,
-				     u.vesa_lfb.ext_lfb_base)
-		    + sizeof(info->u.vesa_lfb.ext_lfb_base)
-		    && info->u.vesa_lfb.ext_lfb_base) {
-			screen_info->ext_lfb_base = info->u.vesa_lfb.ext_lfb_base;
-			screen_info->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
-		}
 		break;
 	}
 }

