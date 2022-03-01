Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F454C8972
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiCAKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiCAKkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:40:21 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB8A53E21;
        Tue,  1 Mar 2022 02:39:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbpGLYwlyKhATi5jKOzpdR4oGAYtTftiq4eal7TJAH7AD5+p7LmIZ6uqI9IM4zsgClFCJ8Lq7QEzL93lm+Ztl1iuUWYphC/naLnJlCK5H3FdW/wWp0Q6b7XwshrioRvN6688ECZA2DEmDIh/oEbA41QQtxt4DYqHpahD9KuaqkiTFBXmLg06xXVaXadvVawyG3O5lcESlNp669tTKIV+mjNzItN2Dfp8I7vZvUX7Hg29bhcl/0bm9UDQrstP7Q2ooMrRyuiZ9UfWX63VCHA46EgJsd73xHPoz12NkacEEJtrxNtq/SxzZ7VU0fxq1IVGNnq2Ih+b8ECmQEIKcYv+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u300+XqTGS4GD8QjeIFQHtEjW9HYeGw7hLOJTHhin+k=;
 b=KQfS/uytx/O6hPllBIYOA1E+hW9QKHwOgIDBCpXLvId8lVYB+rOlXSUNS4bVahyPCcr2k+k2lCgHsrFXChEpXF0p+DQaa18Os70+x2GLyoNcEhjKbSTCV2gyOqPIGJCftI6N0teFqo3LEOVqdj24aJNwSGpjzIFx3fnrZXkJKcyijib477LNmReDL0S/FD2+y9Rz50JUZPcmvCxltT1dmLG1D0d4TJJYtAQpSezRVOO8eU5b79SEn8UZH7ZdfGP0T8OakG1YEzgWEcdt01XSpNtDJgZt8WYCd9gheYN7z4Wh3ftQy+n7eQAQ8PA56Cgi+XSfTv0ZYdsT3As+v162bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u300+XqTGS4GD8QjeIFQHtEjW9HYeGw7hLOJTHhin+k=;
 b=g3YSzDdEm0C7sFx5loXwqF+CNMzfhApJVEOI01sm4iN/xMiVnQTBEas09LIsOeHll1QaiX0odk8IZVO63tOaEf1tcUofrqFXu9p9VUfXyxv77RHIOgf32cns1gkkuRugKBbMI6+/GG8stcpDffAbac8Q8lPkKqnQVNtg/ZBwxsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TYZPR04MB4925.apcprd04.prod.outlook.com (2603:1096:400:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 10:39:31 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 10:39:31 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v4 0/2] hwmon: (adm1275) Add sample averaging binding support
Date:   Tue,  1 Mar 2022 18:38:58 +0800
Message-Id: <20220301103900.12637-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4701194d-6b98-4fc3-47b2-08d9fb6fc4d9
X-MS-TrafficTypeDiagnostic: TYZPR04MB4925:EE_
X-Microsoft-Antispam-PRVS: <TYZPR04MB492594BC729886BE9EE8A62E8E029@TYZPR04MB4925.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBu/HsaKu3/ixGD8dgDRAm8bTQHbmu44llBrTMAgWeIMiD1ADCRTRIZH0ZsfOaGDjbhi3bs+8zF7NnHbIxWZ3n3FfKA403DNWAYZ3gHiP/0AQDJBjZBugjRZBc3ZW9EflvlbLOCgX0xr0XFLDyVaF9XzlgTjiO9LyzB4W1d8V/Quo8ygJZHAi2DKMRKNaScTqJYxhNoh4zCh5uWHuKfYCYYSCbSxdn+AfES4J30rvrlSz/+DVI96rKUWgvmB097wMO/05Jc7OTU3cmod1l/fabMStxlHUqMp+dX7zagCMwiXI9gOqE3kPAe6bSNJkT20lZlBlBHJ+shb/B9fTGRHBXuEl7bZhDxSB0/QCMCvK5GeS/bisIKKwdIrdBEID4GRsBFF7TfzgkEOjyWDh7ZHP6zFUjizq9yjbwDaZhzaGTex0sXVlOXT8le0vY/qaCADUZoNjWEtJR3bd1lHGFoFDf6EA2s6v/Zd8n/w3msSKzFVrx5TjbZsFQspg9r+HykbqiSbBy6MCiqMO/fjiSRnNDKX9EpHgf40fZtXOrsdWtmQ1ns7jrUuDyyvXE+4Q/3DkqjkOvzeJT7+ce3X96Dn5WFwSQ8BXLWhlrx9r9JVSt+1zh393X8BEMODOgWjbtNkQ2e4so82SWgu/xxCARKjL31jlWuMqyryIilPD2AYLIbEiTy+bbfiWlb3xAiXIcO2jJEtNfS7oz/3oMbJFwQ5rzfGkK412MJaRAtVvYYSf4phl+nlVguFzZGTtALAMa8433BF8gRqZIEWzyf/of6Xoa3Nnypy/AeHMf5CQOkOPVbzEATR+eusb6MSCFu3BqIL6OuzUAxqNQ9hCG5HBgyRvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6666004)(966005)(4326008)(8676002)(38350700002)(52116002)(36756003)(6512007)(508600001)(83380400001)(110136005)(54906003)(316002)(1076003)(8936002)(38100700002)(6506007)(44832011)(86362001)(2616005)(107886003)(5660300002)(2906002)(26005)(186003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3eWxFhCHpClSNhFBIOxFoUbm4dK/0T8+JSBtbBk5Rh44xbsyK2GRo8erG13k?=
 =?us-ascii?Q?5qb5mYUWBNv8ykf0HmEC3xpoPXECEOKDLvKeax5z16gjPw29ehGDVX+ey55+?=
 =?us-ascii?Q?Ltmd0MWLLgu3Boe6KXEP9rrsMTUlWblGyUyqRZkczQoBW/TlekA09ol2A+B2?=
 =?us-ascii?Q?uRSGGu5enILxCeSd2EGTe5eERAWjqq1gmZEDTZpD4iLJG+QAokQDi3Guqs0O?=
 =?us-ascii?Q?9AjqD0LQncFGf7En81qJloMewQmdlJ5DcfpGj4dUA5gju9Z/ecchA8wkVEBQ?=
 =?us-ascii?Q?s8qaP2SzLMEZ4yNR8RzLkwXTf64b5kKZi0x9oC+R8Byz4bwP6jgP1YD26eej?=
 =?us-ascii?Q?il2vZiL8ZkmMWWNHTrvaizKAcHZCVASG3G3xgvmxwhisRatXHE9KG1OU5ufY?=
 =?us-ascii?Q?YrmQaVdyx0uq9exIah9PN2zDKyeyiYsv9psUW6MgynvX5deFTwtazdGKBouz?=
 =?us-ascii?Q?qnTy9o+JM5VxWweb9tbjytz7YxZcxO60W+PHzuJoXZXzYGD165PiiZAREIgq?=
 =?us-ascii?Q?4/5e08E9q5WA/gxkG2g6dTS2BhSIA1YMMd+gbs+SXJLvfNwUz/VVMH7EuMvk?=
 =?us-ascii?Q?MdhRQnjyGmgSIi7ETit1aUBDt8ue63HteV6JNdFw85Abyk0CKJymdKStlmjQ?=
 =?us-ascii?Q?YwP11WSVEkCsNomN67J0iwDzn7tA6wMRxmaRPVoz+KgXFxOMaiVlCJJTDFBM?=
 =?us-ascii?Q?sYLR1+Ve0Fo9+8iuumK3LrWiXgVe0p1HXbcocHm7v/0DJn9ihZ2f7FaXPxM/?=
 =?us-ascii?Q?xDb/2PDBm1TZLl6GrGGzcwa4pC4PyGMFJkXtNtoXJzmfThexbM8RZr9VDfRc?=
 =?us-ascii?Q?K+5yd1EVOykhLWaJdGRtwBuIG5ydut5CNqgop4lJxXsx+3h4mHLW1gOLGooI?=
 =?us-ascii?Q?+K9O0mc3wpXDINcX8xN7Sv4eCtXG+n97nSRMjqcfQwcuLSvsVX/cKiTCKN6g?=
 =?us-ascii?Q?nquVUo4u6EKa9PiDmP6ORew8x12bskhpMJJTLmzYzg1xUsAXBDqJ2ONrJsHF?=
 =?us-ascii?Q?yoCDlIA0RWIMKXACYjlmz50m9LXf2ThPpZpohTi9+hOQg+gp+vd6fV73a9LE?=
 =?us-ascii?Q?S1++IOAnOC/Ry4OakBoXiFpzrBjMZsZgFZy5nVyfAcOZDS97Z0zL3rBvTN/d?=
 =?us-ascii?Q?d6s4skxPDzxJ45f9Nwv7HYhoEZqpOFZWmD2mvAUhIV8ckN9lVfXzHq0hIR+t?=
 =?us-ascii?Q?iSttKYtzHg1qJGyoYDMO1txG1LmKmcpTgbyu6KPbV6MrkOiDycrMgfvvE0rQ?=
 =?us-ascii?Q?kluZ6bDDigmyA+m6/HQ2mmPouDLTJ7y3HHjoHCoLNH4o3rHmXyTJB0kVQNVI?=
 =?us-ascii?Q?8MZrljaFNVHKlpFRlkyEB6xfv596hDAeZ4jgNvDBok83sPiuaEgy8UBrN9bQ?=
 =?us-ascii?Q?XDxhbfuTU2yvyHxeDxz2jZA3nWcAWqiRUwZdCDS+hiLuyVVz5FKf8Y1jhfMO?=
 =?us-ascii?Q?d/xO2MDehiPXObAHWqDIndsU1oTq12+hWqRWQaXr6SoWII/HdwEyNGzqKXIX?=
 =?us-ascii?Q?a9LqKVxmHRkbvt7OW01Dcm7A3NsKCqoDmCHojnemT5P5S7DC/K1bossn6fmm?=
 =?us-ascii?Q?pgC227aN6wskK9Ee/KHEkRM7PVFB+h4PyqGJWCrJGODiyZFD2DomzSumg6eO?=
 =?us-ascii?Q?L3hRNkTRPN/vBR3/NXhjAf4=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4701194d-6b98-4fc3-47b2-08d9fb6fc4d9
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 10:39:31.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jOJ/r+Js5Cy6i6M61mmoDABhhqeDnT2wzfYY6ViSRyf0cOb2O8/tqWcEw9UVX3HDNM1ufUEWyB/Z5KJeRylRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4925
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series allow user config PWR_AVG and VI_AVG in PMON_CONF
register by adding properties in device tree.

Example:
	adm1278@11 {
		compatible = "adi,adm1278";
		......
		adi,volt-curr-sample-average = <128>;
		adi,power-sample-average = <128>;
    adi,power-sample-average-enable;
	};

LINK: [v1] https://lore.kernel.org/all/20220223163817.30583-1-potin.lai@quantatw.com/
LINK: [v2] https://lore.kernel.org/all/20220224154329.9755-1-potin.lai@quantatw.com/
LINK: [v3] https://lore.kernel.org/all/20220228103716.10774-1-potin.lai@quantatw.com/

Changes v3 --> v4:
- add "adi,power-sample-average-enable" property
- add sample number cehcking in driver, only allow listed value
- remove info logging, add error log when invalid number detected

Changes v2 --> v3:
- change property type back to u32, use logical value instead of register
  value
- fix typo in properties description
- add if-block to descript "adi,power-sample-average" not alloed if
  compatible not in the enum list

Changes v1 --> v2:
- use more descriptive property name
- change property type from u32 to u8 
- add property value check, valid range between 1 and 7

Potin Lai (2):
  hwmon: (adm1275) Allow setting sample averaging
  dt-bindings: hwmon: Add sample averaging properties for ADM1275

 .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
 drivers/hwmon/pmbus/adm1275.c                 | 40 +++++++++++++++++
 2 files changed, 84 insertions(+)

-- 
2.17.1

