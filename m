Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE38B51374F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348617AbiD1OyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiD1Oxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:53:51 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A02A51321
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1651157433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A8stDmbfCiVRa3vsDBlpsWtwv/Zq4Potk7/5iOXXUcg=;
        b=CWdru/tsk/P1o50C0hbiL5mfOUgEsBRnlleb8RkqKDscfyg0kZeIXuz/Gs4OrOqL5D10BL
        JSbiIBlbowZzMLpxnTuue9Bh67BuwWoxvrtNBwGfbE5keje9n9LD/S7YJjaHrAo6Oi0GMY
        bfi1CxikmqpokP0yx/86iFIxsyWUmqI=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2168.outbound.protection.outlook.com [104.47.51.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-0qg2GuooMEW1WEZFkg4Qnw-1; Thu, 28 Apr 2022 16:50:32 +0200
X-MC-Unique: 0qg2GuooMEW1WEZFkg4Qnw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2h+kAAQPHL4xIewzr3NRvSjnLptGoM7xR11LrxyaADvdA1u39WLRPJxqr26w2U575LvsaZR0fyorsgyZXLbMMzV598LcPK4As3bneo8/gbauhqa5L7UadX6fJuNA3bX1KmT9s+huEL/gfA4wla8QCycP9yWFczcyLs8aoBX53l8iBa/6xSmv/l/kPVvMXIfS74qAPjfCpe+w1X36t0Zurnkes6V6ukqxEABPPxx8MKKR2nRUZhzhZ8ri3UAeJ+eXG3J3LW6dtgFVAbQGqdslRQEn0s2T7ug71rcLQHYwS1ESgKiSbmL/f67ubL0aV/V5tyz5TOWpOcyPQDGf6avkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8stDmbfCiVRa3vsDBlpsWtwv/Zq4Potk7/5iOXXUcg=;
 b=YYOBJkdWb0WXvvko1jgTtbzyftqORJnlMdP6V3gIhrxe/Fx28W7Tmb5GqU9N+X7r5P5lHaBVS8JcKZvsRDE0sdOYeWBzKPYxIXst6p5eVskC8eXcTztJ2HVaW67NQxiMLSLTUZmJzIQjDqbeFi/hnRrFzr/hBo/dlwTOrZjJoZsllUpSYfJ1KNP+WbG6IxeE09EqpWmpJ3p3w2o7pgBqvaEhbsEiL3B25vWfg1+WjAjg/PcDcWldOz9qv7Xn4gDmvXXj5ogx92MjTQCvCe4b7JYS1PDJ35PFhxbWdo0j1op2qFMr3yyyJE+lJxx3FASn5KiSFpQsVhCpfW6iPLh4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8616.eurprd04.prod.outlook.com (2603:10a6:10:2db::16)
 by DB8PR04MB5849.eurprd04.prod.outlook.com (2603:10a6:10:af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 14:50:31 +0000
Received: from DU2PR04MB8616.eurprd04.prod.outlook.com
 ([fe80::5cb0:5195:4203:7c2f]) by DU2PR04MB8616.eurprd04.prod.outlook.com
 ([fe80::5cb0:5195:4203:7c2f%8]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 14:50:31 +0000
Message-ID: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
Date:   Thu, 28 Apr 2022 16:50:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0120.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::35) To DU2PR04MB8616.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1f523ec-68eb-4443-86a6-08da2926712d
X-MS-TrafficTypeDiagnostic: DB8PR04MB5849:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB58491B0CCDD54404C13B3C33B3FD9@DB8PR04MB5849.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eNEtXfzIfXfvCzquEglnq94qvjStgpj31QQ+xz6tqAhmqg9V9s/nIn6jXeGVQrX8ABQgB33jky9eKhCsxAuJyA3qfxFz2MrWGi3n0NzrZ80saf1PtDJrasT4GXEWm5FcirGqe9rT69WQUUXtzuPJgNuT6lnktgvRuEZGTZf/AsRJBmbefZHRLxz8kDJN5WRezPzLt55eyaGaZB0lQik9nKE9tipP8OsOByso3Ep3hyYsYQKQcsvv6m1VtnokhRytKKMflUNlG+DTSjFZswgjL67iJMpERCWB0h84AqmjHaRF1aDZtuvf/baMvvtwbzUYvb/G3ezQWYU0kmmrsSbfVNbUCHKo72RSjcdWDH+dhskhmCLEO8b2o288jF98uRLyCPqid7GkULqzu0xVkoGgFVSmdyXvmVTDOb3/agPvR+3VIXtq0qN0L282yzMejPSbCb0G3EIDzK9oBpWpBuzvOXjJ6Od+/GXyd/qI5b6D5ySGJg18V3nHCbpt1KDZhwXGKhLXMUoFdNezVjqkDNtuLqjugNFriC67KTTWk9vZb/y9VegAdidyZC4WOpTUll16+hvmWcps2s2ADNZ9I/KoKiPtRYl8+mLVmVQTlQV99okbcR94EQ1CLINzNQza+sW/zZ++WAH+P/oXoBSirdLnnQE/qs+MpW6ZsxQmj3Uve9RRSkrCm0nqZRHWblqNcmWMEcjuNGRGgpI0hlClLv1VfjEiDZqOh954KPFU5H3xC64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8616.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(6506007)(54906003)(316002)(4326008)(8936002)(38100700002)(508600001)(66946007)(8676002)(86362001)(66476007)(66556008)(6486002)(5660300002)(31696002)(31686004)(2906002)(26005)(6512007)(186003)(36756003)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdwSDRXN1RXaFRSYi9UZG9QQjNudVZJRUk0TzBDVkhlYWp2V21jN05UZzlV?=
 =?utf-8?B?VmVCOEIrbjRScXVibkE2NmlHTnJlbnJMMXZ6a01zZGJqaHhtRm91WDMyc2dM?=
 =?utf-8?B?VWtONnYxVFZKMEZhMXRwbzZ3bk5sZ2kyTlRMblJHZEZuemZ0RC9rTk85UVdl?=
 =?utf-8?B?UW8yWE1acGY5b2xQTlVudW9QZVloM1RyQTNCb2JzVEYybWNyMHI5Tml4Z0RZ?=
 =?utf-8?B?dFRmNXlYSWVlYU53KzRVNHlkQjNwUGRpcDlPL2FNTFR0Y1MwTzlBNWRCYjA5?=
 =?utf-8?B?RXdqNkVWSUlvaTBrVE9ZcmxRb1RlWUxTOWJZeWljQWZQa2tyQUtXaWdhMVJa?=
 =?utf-8?B?eUFnWUMxZHloQ2hKZ2dna2tiOW9laUFzR0c3MDl1NEErZGFhZ3hya0tlMW1W?=
 =?utf-8?B?bjNDcVF4TUN1YldYTUhqaUE0WDZCTXhEL1R1dUJORngzTHRDOFVQb3g0bXRY?=
 =?utf-8?B?bEwyeXVQd3N3UGtDdGp2NWxEWHZyNG9LOEcvN0Q2anpFZmsrckNRSXFrem5q?=
 =?utf-8?B?cFJJcEp5MTNxK0M5TGJQTCthaFUySFVWM1NqNHVRekN5VGE4NERWNTd4QU52?=
 =?utf-8?B?OTJXMmFYbzQ3K0xlL1R3V1IrNDNaTmZLRWtiNkpBZVV1VUpSMElwcXpCaWp3?=
 =?utf-8?B?dEdCNEFYUlEyNHRQclVtOWhtaS9XY0VVVnhrbVpUN0FwZ0JHTHVMdWZveDht?=
 =?utf-8?B?dEVpWlhoMTR1aTl5cnpJcjI3WnJPZVVFZVJ3SVVCZFYwRTVlMktueFJtL2RG?=
 =?utf-8?B?REFWU1JoZlNwVVJ1RWtuUDJUS3B6UGFRK1RqUUpES3RHNk1nb2d4SHdKSEp2?=
 =?utf-8?B?NUN6cEQwYjI0cFNkTVdYY09YbGJiSWwybmgxSDRtcjhNU25DUU9CYnhtakJW?=
 =?utf-8?B?dmFvNVR1YnVreGxOTHZWcTc5Qzh0aEhDdmU3RVVpZVdBbVdXbnRnWG9DUDA4?=
 =?utf-8?B?RmxXaXE1UE4xa3F1bXlmZ09JZUo0OVlPTFZFY3U0QVhVL2JRSm5jTTVPdFBX?=
 =?utf-8?B?cjdJd2V0WXdBLzVYUHpNWGVTcFV6S0RYeUs1RUM4bmhLQmI1Z2tvdURVTWt3?=
 =?utf-8?B?S3R5NDZXYTlGNTJ5VHo0c0N0c2l4dXM2UFB5M3R1bit2dVE0V3dCZnZXK2Fk?=
 =?utf-8?B?KzVGREwrekZZdzRZelZmTlNob3llQXpWTjBaR3FreVB0YnBwcUFKN1IvVnZ6?=
 =?utf-8?B?dklET3BEbjhJRTBDUGJvT3ZQcUNpbU1oYkVvYXEvdmVuVG9sSnkvZ3hwaXRY?=
 =?utf-8?B?S2REc0UzVVp4cU1UbU92L3poQXlqMzluUmFsTjU0UE1ZOVVEeVFGeFg3K1lJ?=
 =?utf-8?B?ZE1sQTJrQlVQWnozRTNGVm12OUg2ZUtVUk9uTHZXS3ZURTMxamJpVEQ3RWNj?=
 =?utf-8?B?Z1p1QkJ1V0ttZHZKNENCbFFsZzNFcjZNVkFlMzByd25XZ3FGSnlqRXFvaFZ6?=
 =?utf-8?B?d082ZVBwdFE3YXBuY2NYbEZleS9GZ3B5NzEveStHVjNJdWorMUVGMDd4NXFR?=
 =?utf-8?B?RnN4QUVQRllzQW9IUVJwK0tyL3BXR3ZDQjh4dVl0SzVFS2dPSlB0cnlNTGc0?=
 =?utf-8?B?NnlMazA4WVFVYmNLbU1HL0JNUytEV3EvWjZGMDUzenVxYVFhalFHalU2aGU1?=
 =?utf-8?B?bXFCSm5YNlNtNWJJVGVrR3doazFnSnFEamY0S1JsM0tsbzRVcWM1a2IxczdQ?=
 =?utf-8?B?U2Q2NS9vTnNFbXk3NGdKNTZvM2NqVm5NVEszVHVrUkR2QUx2RnRESlQxVGg5?=
 =?utf-8?B?TlViMXo5ajJKc0JNRXVRMkZ0THQzS1gzSFc4RHpPeXoxUjZLYnhjaWZ6V3ZS?=
 =?utf-8?B?eGZNSWtKVncwUzNkRzFwREwxNzhRWklydkpJaDk1V1UrcGxzMExiRzFkYTNL?=
 =?utf-8?B?clhGNTlKcHhUVk9jZ1BobmFOYkxRK0NPaDRRUXB6Z3RrTnQzT0VXK243UHgy?=
 =?utf-8?B?K3lFRXkySDJvSjY3Zy81NEJ1dTc0OGRFeDJVMGtUVGtwZDBhNDhhTVVSWmxo?=
 =?utf-8?B?YnlOYzFYcUlkVFhFWTRkNVlrRGxyT1RoMmVLSG1tM2I0RElTQ0V3SkZDTUJ0?=
 =?utf-8?B?Q0RHdmZBbnRGeEdIVmNKZ3FIUCtYR0FPNVFHUkV2NFlBTWM0MGpCTU9vL2pL?=
 =?utf-8?B?c2dXbUVYaktnVTRYTkNFS0xDTTFBNkwycGYwUUJHQzFEeU5EMUhoTERwbjli?=
 =?utf-8?B?ZDVYcUV2YU5QWFNGWjFFV3ZzSmhUS1RYY0JTWG5IK3pnczhDVHZxOEtjSnVv?=
 =?utf-8?B?MHhFZEE1bU12SVoyYzV1ZkZib1RrZjBIeVloOVdRdkFERk9ybHdIU0NoUTBJ?=
 =?utf-8?B?YVN5RWtlUFFxUFFYVjFOSnBlTloxTEFNVmJDKzRoankrcW9uY2g2Zz09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f523ec-68eb-4443-86a6-08da2926712d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8616.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 14:50:31.1889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbpWWv14azCdUJpNnfE75pXOgbQy2OrAI4hXRb53mRLSGkxEBTRYZwAWFt7kNnI9kPpR7+b0vmSf6kEB6nncJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5849
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
with pat_enabled()") pat_enabled() returning false (because of PAT
initialization being suppressed in the absence of MTRRs being announced
to be available) has become a problem: The i915 driver now fails to
initialize when running PV on Xen (i915_gem_object_pin_map() is where I
located the induced failure), and its error handling is flaky enough to
(at least sometimes) result in a hung system.

Yet even beyond that problem the keying of the use of WC mappings to
pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
graphics frame buffer accesses would have been quite a bit less
performant than possible.

Arrange for the function to return true in such environments, without
undermining the rest of PAT MSR management logic considering PAT to be
disabled: Specifically, no writes to the PAT MSR should occur.

For the new boolean to live in .init.data, init_cache_modes() also needs
moving to .init.text (where it could/should have lived already before).

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
On the system where I observed the issue, a knock-on effect of driver
initialization failing was that the SATA-controller also started to
report failures.

--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -62,6 +62,7 @@
 
 static bool __read_mostly pat_bp_initialized;
 static bool __read_mostly pat_disabled = !IS_ENABLED(CONFIG_X86_PAT);
+static bool __initdata pat_force_disabled = !IS_ENABLED(CONFIG_X86_PAT);
 static bool __read_mostly pat_bp_enabled;
 static bool __read_mostly pat_cm_initialized;
 
@@ -86,6 +87,7 @@ void pat_disable(const char *msg_reason)
 static int __init nopat(char *str)
 {
 	pat_disable("PAT support disabled via boot option.");
+	pat_force_disabled = true;
 	return 0;
 }
 early_param("nopat", nopat);
@@ -272,7 +274,7 @@ static void pat_ap_init(u64 pat)
 	wrmsrl(MSR_IA32_CR_PAT, pat);
 }
 
-void init_cache_modes(void)
+void __init init_cache_modes(void)
 {
 	u64 pat = 0;
 
@@ -313,6 +315,13 @@ void init_cache_modes(void)
 		 */
 		pat = PAT(0, WB) | PAT(1, WT) | PAT(2, UC_MINUS) | PAT(3, UC) |
 		      PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
+	} else if (!pat_force_disabled &&
+	           boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		/*
+		 * Clearly PAT is enabled underneath. Allow pat_enabled() to
+		 * reflect this.
+		 */
+		pat_bp_enabled = true;
 	}
 
 	__init_cache_modes(pat);

