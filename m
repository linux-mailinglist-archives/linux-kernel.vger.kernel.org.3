Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F494BDE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349586AbiBUJaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:30:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349309AbiBUJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:21:13 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150125.outbound.protection.outlook.com [40.107.15.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782B436156;
        Mon, 21 Feb 2022 01:08:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CepL/Oluyk2X8DYdXihYiMZ6niAtIcs4Tpn9N/nN2m2tVTyf3xOiLgwK1pFdQPq+WE5LDsEY3STkbmQAt4MZ4HA2d9zGM75KxpWTttzOsMwiEJGNXoccGi/n+kOOraFBq28L0K4OzJKjv5WimLwMVIEJIw7Jp0Qc/NP6yESjKlmv0vwzPLmCsZBcLPiC5p4cdk45XLx9wzXw9W8Spay3/TM9+pHmRu0miWi3EcCbWKAVmT7KBkYEju+L6CqbpmD6hIEZO+ZYzlpm1ScizHrXQHa/kB/jgKBWyD4+p/nVayvXHuejZ8GunUkCJA297bgpyU7g7rOlkXUz51EBge3Gqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dw0vsA8BDgjDXLZ07tLY6bwFEg8/PQbyB4cD62Njg2U=;
 b=fhEjeCAwosBFiZdGgsz2tQ9LqWdlvVGtN/i3fqntIl1BJ1jGrRWUSIzEu2vJMZwH5jELqYQj2hVZx6VT+kx2ihL9HQuQv8ZuVbZKZe0p0Y7exWvsp4cCeTj8SqcYIpo5qrUMELhTha7Kml142s8jNv0ZdGYN0nRLuxGAaKxQJOc5dmDCBkeSBMg+U2458NdrQQLuSHcL6dlgV65dk08s/rfhTaD2u3lWdADBiygO/1tUlPXHc283OWJU83s2PzBhFlLX2tfkCwKqRcbiC5VktZ1qCOdYrpwoFJxIxWy4gZeiEe9RNJKnZOn6gq8jaTaCBuVCnb0HJLAslTeUSavF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dw0vsA8BDgjDXLZ07tLY6bwFEg8/PQbyB4cD62Njg2U=;
 b=GVFkixZummEl0010T/0amOhOYTFxDk1/LZjfHmY3E7VWlIh+OJ7NpZJlX+S+H2Rdu2K9UgY/s34zIdgCcmH9HvNPUx/oNIWP/bJD9wXKfMgnY0P1hfxWGcbQKzctLSHO3sy0d9HpBsevJmT20BaR6dJYpauSQHHrUq3qYDQrjp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by HE1PR07MB4201.eurprd07.prod.outlook.com (2603:10a6:7:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.19; Mon, 21 Feb
 2022 09:07:57 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::99a2:6f44:700b:b796]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::99a2:6f44:700b:b796%3]) with mapi id 15.20.5017.021; Mon, 21 Feb 2022
 09:07:57 +0000
Date:   Mon, 21 Feb 2022 10:07:32 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: add tmp464.yaml
Message-ID: <YhNWVLHYVtCvdGhi@localhost.localdomain>
References: <20220218150908.1947772-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220218150908.1947772-1-linux@roeck-us.net>
X-ClientProxiedBy: MA0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::14) To DU2PR07MB8110.eurprd07.prod.outlook.com
 (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b18c3831-a318-4bba-7fdd-08d9f519a6f3
X-MS-TrafficTypeDiagnostic: HE1PR07MB4201:EE_
X-Microsoft-Antispam-PRVS: <HE1PR07MB4201AB2E8D5E7C2CA8A49E94EF3A9@HE1PR07MB4201.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUQXYZ5B9etPj3qK/EcwvvgqNJtWLpXklyjkGwCVnCJb3XN8+FajHscqtDfnbHTEwGWqUTHhjaqSv4T9h4gJec7nDRM0czTfzExOH3WN9I4uQjuWTnZWo62O+whQT0i8eRThylfJl10cgyFDJd/dPey4mqu7aMQn2n/kcUiJOr1yrhwpvZ8Y0OxvbaerX0Hi3Uc2jn2e54yXn+mW4SlsbiosHDi77i3/GwlHc8ObaHZUz1OGbolrxKrJLQ0AFkM/aBfT1KXxBiSh59BjbyAu2UG8JT/KVranL4E+lDNPtlKTNLtfSU8v2D8RCxKLpsieZaQOfcDM/YvUWB66gdNYGqlffa6aNlvXBIuttDXLCtwJlX0YhPkPxovp2Hgh554scFLkDvm9DsuU7xhXXrT/IhAGIdWTseqqjdw/Pd0rHesLZ2NzGH/dCjCnqT1WAJrW2DnqyXGdLWgiuoeVkRqtWhoOGjLOi0Yce+AXmjWvsUVDBVG5G6q8HLAuW43LZGAtrdQX5SZHVhb1O7cTDQAxVe+JN9LoGovC/wY1gUz9TFcFaRRNgmIFNNPxXgpwqozdlbQqPbqISTeEgloxbzdv0b+LXNFCE+Ob95+XxZmJipc079re8/Ut50/rWhakpnQmBIsly7BpwbrqU8LNJTAnElBA6xBIgGZfsqeQL7yi8ZdKeUhOlL7w6KqYQWtgaFwiPUWr/vJ/mJvsSQ4QEGJ3o7iFIcmLujn0pqQ5L0TZwuONO2nO8OtYHXwTC3dnaDXpXKbgowoqXa/pncCp4txV6Cp2blwTHcUZ8sYAKx59I7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(316002)(83380400001)(6512007)(86362001)(8936002)(6506007)(52116002)(66556008)(66946007)(66476007)(4326008)(8676002)(5660300002)(9686003)(6666004)(26005)(38350700002)(38100700002)(966005)(6486002)(2906002)(508600001)(82960400001)(6916009)(186003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGV2aGdkYW9wTXovaUtvL1I5eW5nSWpaUkRaMU1xWlhMTVBDNHNrWlp6RE1o?=
 =?utf-8?B?YnFSMDdqY205S05QcEx5QmJsSHVjd00rSitEWmRnZnJNN2RWei9HT1JTTVVF?=
 =?utf-8?B?ZXZxOURjZGdiQytkM1B0U0JLcGhxcytnNm1NT2dDZ2E0K1JTU1hCVHNYM2s3?=
 =?utf-8?B?SithNlJhRnhCdUUwUkJUNTJ5elh6NDJwdWc3dGZoNHMrcDZ6djVzQ2FXMzN5?=
 =?utf-8?B?enJtTmltQ3ZTSnV1SDFJVkExbi9STzJzMy9NeStsRUpXK09WNjBTS2t6RUpN?=
 =?utf-8?B?U1ZNRjRVSEwzVDl3TEUvN0xFMTVhUGtRNG82RGV0cUtBQnZyOTVWUDdML2xi?=
 =?utf-8?B?ZXdkTGpaTlU0Z1NBWHBLQmtlcEQvYkNNM0g0RTdueDBXYkVPanAvTE9DeHNW?=
 =?utf-8?B?clk3bHRLSmdkajh2RWZVWVl4V2JhVWtUbS9taDdvV1ozZFRJSXBPWjJ3bC9j?=
 =?utf-8?B?SlZyTUVtNmg2OUFocS9sS3ZxUnZPdUpoRVlqc2RQT0ZZMDFEWWF1TnFvSzN5?=
 =?utf-8?B?UVcySTIvQzhwME95b2lIVjVVb1RqTkRjdXhXQ09ldE9oRUJ0RlpMWkF3K1ls?=
 =?utf-8?B?cEg2SlhqUFZIL1p5TzJ0WFpObytjZ3pnMFE0RGtDdFMxN0ZqZzVvMk5iU04w?=
 =?utf-8?B?MVVqYldVclorNk91L2ZCV2NNazA0ZE1iUWxYZnZ3NUZIcnoyZ3QzTFJ3a094?=
 =?utf-8?B?ZkRlbjdiOUROeW5zQm5mNnFIU0VUeHkyK2NGN050UEtaZk5IU2JEQ3J3TjFB?=
 =?utf-8?B?NWI1cERKMVVuVmthZUxqTDZuNGc5OGNYMjIyc2lKS053NEdWa0tuZENKRmJt?=
 =?utf-8?B?Ukw1UzJ5UWxhYkxhUVFsaEpnU0U3OUd3RWgxZFdPcUhGNi9DaFFCQVRVbEtF?=
 =?utf-8?B?SEQyMlhBbE95em5IV01vbjh3dlgvTUdYdUlWRzRJK0lnUWJEZFB6VkFiRVVL?=
 =?utf-8?B?cFVvdlNCQ24wK3c2NW5tV1VXWEdsM2V5aDdXcDVlVmsvcUQrNkZGSm9JbWho?=
 =?utf-8?B?N3Fmem8ranlDbFA1L2xvOVZxT2d0czB4c09CNFBUMUFLMG9qTEFIN3c2cXVj?=
 =?utf-8?B?Ni93MmhSRFpVVCsyMTQyaGJMUTFjMk5lWmdSMDRXRE1CckU3cFRqc3Q1eENs?=
 =?utf-8?B?cldjYnd6RXdoQ2ZiQ0Jod2FIM3ovTTE4UHkyL3kzZXlDT3BCM1lLeGwwbER1?=
 =?utf-8?B?UkFtOHRNcHVvSjB5am1sTHdYUnZ1L20vYzF5RWxGWEUyTUVSK3NIOS9jODVG?=
 =?utf-8?B?T0N4N3hPU0Z4TVpaWVpmTS9ML0FFanJvaTZ4S3B1aW52eFJsKzdCMzhqTzNE?=
 =?utf-8?B?WmMwbGdleS8yd3d6N3RVSXlPZzlnSmd5bCtZQ09oNmlJc3VWb3JLb1pGSk9Q?=
 =?utf-8?B?K05TdTg4S0hKVGIxcjVJck42UUVYNTUzbVVPTGRXWEpucmdWa0pON296OENY?=
 =?utf-8?B?WVlTc1E0dnJUekwvckFkTzRiV3ZRNTBEYjhvVUQ0NC85ek1nZTIyd2owQTNY?=
 =?utf-8?B?T1FGbVRCdEtidlNGTlJ6d2pOMDZydmNrMDQyN1ZQYWhqUjB4cHFMTldRNTFY?=
 =?utf-8?B?eHUyQTJtSmhwSGRTQlAwWHFFTGZweWxkN2NPQnVMZ3FrcmxUZFZnajlqeGF2?=
 =?utf-8?B?eVlvaG5uRytYOEVlS2FZVWNPazAvOWZJakg4K3JhMDNLbDlnbU9oaXg3czht?=
 =?utf-8?B?SkZnMzg1ZTE2K2M4dWd0WU5QNUNQcXZlS2h1QnBYMlZWbzRBU2dnV2s0TGp3?=
 =?utf-8?B?Z3dNcFJuS042NUt4SXhBQU11TFY4N2tOTHdtcG5YM0FjNHV2NEM3NU1vcXpz?=
 =?utf-8?B?R243blBLQkpLYmdCb1FmMW5JME9IWnR6MFQ3dzl1SDUrMnBGWEdkNndkcmN5?=
 =?utf-8?B?R2pnRGZMTXQxRytJemVHVXZtZXRoSTdaQUtRNWkzU2w0TVZEY1d1MVlBMFdK?=
 =?utf-8?B?T1FNcWxTS25jd042cnNnQnJlMnJJQXh5a242SjgweTNuUzUvd2VRNHJ3S3gx?=
 =?utf-8?B?VEFEbVVSdE1RR0puamFtbGNpVmFES0NsUU9TU1B2a2tMd1BNT2ZFa3JJUnRx?=
 =?utf-8?B?NHpQSDhSUmhYTXlFWkh1aG4yVWs1V3U1VFJ2MnBjQWRJelFreHNUWDVNb3I0?=
 =?utf-8?B?anI3MTVqRE9KNjZyRnBSRDdkM0hORXg2cm1zcHlQYUgzTWFkS1p5QUFwMCs1?=
 =?utf-8?B?MlRkTks2T0dsczVLRVE4ZnExQkYxWWVlMkYzZUNQVnAzUFRPV28zUXhJTm9r?=
 =?utf-8?B?WnNPS1U3LzlpSWJ1QWE5UHV0VG1BPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18c3831-a318-4bba-7fdd-08d9f519a6f3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 09:07:57.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp305uiDTMInUJNGCP7Ev9KWB7Jdm0s4VexqqT168M9Sq/ayyqrRgB0Uj8oMlrOg2QpHwshcDsqLapVJ3bpn+maVZjzA1o93AV79VhDFYGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4201
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Fri, Feb 18, 2022 at 07:09:07AM -0800, Guenter Roeck napisał(a):
>From: Agathe Porte <agathe.porte@nokia.com>
>
>Add basic description of the tmp464 driver DT bindings.
>
>Signed-off-by: Agathe Porte <agathe.porte@nokia.com>
>Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>---
>v5:
>- Dropped ti,n-factor from channel@0 example. Added additional
>  channel to examples to show positive ti,n-factor property.
>
>v4:
>- No changes
>
>v3:
>- Addedd support for TMP468.
>- Changed number of channels from 0..3 (which was wrong anyway) to 0..8.
>- Changed value range for ti,n-factor to int8, with an example for
>  a negative value.
>- Added myself as driver maintainer.
>
> .../devicetree/bindings/hwmon/ti,tmp464.yaml  | 114 ++++++++++++++++++
> MAINTAINERS                                   |   7 ++
> 2 files changed, 121 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
>
>diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
>new file mode 100644
>index 000000000000..14f6a3412b8c
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
>@@ -0,0 +1,114 @@
>+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>+%YAML 1.2
>+---
>+$id: http://devicetree.org/schemas/hwmon/ti,tmp464.yaml#
>+$schema: http://devicetree.org/meta-schemas/core.yaml#
>+
>+title: TMP464 and TMP468 temperature sensors
>+
>+maintainers:
>+  - Agathe Porte <agathe.porte@nokia.com>
>+
>+description: |
>+  ±0.0625°C Remote and Local temperature sensor
>+  https://www.ti.com/lit/ds/symlink/tmp464.pdf
>+  https://www.ti.com/lit/ds/symlink/tmp468.pdf
>+
>+properties:
>+  compatible:
>+    enum:
>+      - ti,tmp464
>+      - ti,tmp468
>+
>+  reg:
>+    maxItems: 1
>+
>+  '#address-cells':
>+    const: 1
>+
>+  '#size-cells':
>+    const: 0
>+
>+required:
>+  - compatible
>+  - reg
>+
>+additionalProperties: false
>+
>+patternProperties:
>+  "^channel@([0-8])$":
>+    type: object
>+    description: |
>+      Represents channels of the device and their specific configuration.
>+
>+    properties:
>+      reg:
>+        description: |
>+          The channel number. 0 is local channel, 1-8 are remote channels.
>+        items:
>+          minimum: 0
>+          maximum: 8
>+
>+      label:
>+        description: |
>+          A descriptive name for this channel, like "ambient" or "psu".
>+
>+      ti,n-factor:
>+        description: |
>+          The value (two's complement) to be programmed in the channel specific N correction register.
>+          For remote channels only.
>+        $ref: /schemas/types.yaml#/definitions/int8
>+        items:
>+          minimum: -128
>+          maximum: 127

I still thing we should have the same format here and in tmp421, for
consistency. If use the same property name, "ti,n-factor" but on tmp421
you have use 32bit value while here you have to use 8bit (which is weird
in DT, BTW), it might be confusing.
Back when we did this for TMP421, there was some discussion and we
settled on this approach, why do it differently now?

Krzysztof
