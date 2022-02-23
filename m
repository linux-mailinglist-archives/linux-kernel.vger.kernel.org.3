Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384124C18E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbiBWQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbiBWQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:39:07 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603E5717C;
        Wed, 23 Feb 2022 08:38:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzFcxAceP+SIryIgZk7Bp+2PmVmPmcTNUkqYovM6CvB7j79/2TjnPQ1yCRQrH5b1qfuwPoGi0rwoI3ZnHv8x4DdlrOfWmdqZnZK/wX/G/k0pgVKtJ6UrptZA5EhYaqd+LobEHFXBSTTokj1F/PDQSqA4f5VRx06G05z9OloS6h6lYtMWkHVXIXmlNMvFoa9C9PEA08DZQBe4LlKFUR/2o7vh1wQtZ/yOyxAALyo4r9d/lL/kJfAnN4vOfcYCYmNVwp30qVp3hCYBpJl4GLaV79DbySYVqWe5lYWk5bD5HBEy/nJ5w0tslcnMM/k6A0bvzvjxL4w1MYRO3r1dtP/nsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks4+hfj3tZdjLL0SMnWiGwBqzW2sTC7AbP3/1L5chs8=;
 b=bIxFR/dEB5pgmymMWiTizZsyRQiPm2X2jByMSntyOsvTionV6g+uzlNwHNWez+KykDeSVntgKYXtIVP6iuMXibOh2uJ8zKF+PJNWSvoIAPJL7+eGn8CdBJqkce6zTEO07SExFa7isxD+yBa3HF8qBl7Ks1lKAXL7O4XrPqTrOVl4TaisIbt7yCZ/Xra8jc6MEDhYy61dN3UQtQFQYjOG5eyLAm6dq/CjHKC2aPvfmB5Qn0ryzl9/jIujOoj860gCIjkxeSrsBsfpCb2jVwFFxRzlUqskcyxLrAabxUOQBOSbmUwGOTPRtkHgF8cb1DLmfwIkgF6g7mM/6DhLiaxfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks4+hfj3tZdjLL0SMnWiGwBqzW2sTC7AbP3/1L5chs8=;
 b=J2LY+jbSffagczVbgc1baPs5lajize9cTrDajLL8x/vj5/xxWBmXAMXv83CvhaMtqYHWMM/axCAzL7QiHCgWhy8u59+CWSahLfYdZAf9GSxdMew7fHMUmNWiBWAH0+QkL0aaQeV+QL1Q4OL5I6TMreOVjshJsk2feYccnvNHoHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TY2PR04MB3456.apcprd04.prod.outlook.com (2603:1096:404:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 16:38:31 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 16:38:31 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 0/2] hwmon: (adm1275) Add sample averaging binding support
Date:   Thu, 24 Feb 2022 00:38:15 +0800
Message-Id: <20220223163817.30583-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd62f4ad-45dd-4b91-3a78-08d9f6eaed3e
X-MS-TrafficTypeDiagnostic: TY2PR04MB3456:EE_
X-Microsoft-Antispam-PRVS: <TY2PR04MB34567E4434F6F718A457CEF08E3C9@TY2PR04MB3456.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuRvHYLl5T2jU/uunARZAY9t21sC6Ydn3XYaUJIme+tNdI992QKiNL68dJ8YwAD6yAt+pLwKE/6QvcABr0QUU4fDaxC7MA8unzWsz2tqiOiwRybxWMZNrgwedSy9VuqODIrZxBAHaTa7tDVrG02FaBLg7m0Yci2Njap3fkTS9F0nCigVzo+nZrObjnUQGOIYJ5fE9TIdQOYtsP0U2onJP+yk9bcujvCh3xIZ59DZAmP8rE5Qfhil2wKHnTeifNwTAURhJhpLd8tXdlkBniR1vzbLrV3NuFH/OAhp4kDOilevMIy7KqsUWGJxbLV57fR3nX4B1I77iPTy8RNhGcUoTnD68H6DlQpj9ymmdTEaO3gnUjEYZqGiZoImf94V1ncIkZXB2Vt5mS7I8OD5ggfFgTYBg6Ew7wG20Xi6vvKADuwOxmVs/Vx27V+hhOqxavKRQyY7xaCTxi9UgA/jkB5A10+OFv/Z8e6pLqYxjawDF9hGdrPuqyZnssX+7bPwRfHse6nR4rd9LVoy/DB+/rhZVlGuowTtOwGoKEbOalBjFLsehZAQyczj1NDcW8AkjS9G1rICGN5wrFTLip/DNym8kLAgKlrWWbHTLbQGIL2eZ9Smn4IvDSvXsZhMCUQ89QPp9aYPEsmQxGXoiTom149HFMmlXlziZfmzlTbUamN1X6JhTAKFFBTYGiAX+RLCm5+22alrGP6VBJpIuJLvt7OjKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(38350700002)(86362001)(52116002)(54906003)(36756003)(6666004)(4326008)(6486002)(2616005)(8676002)(508600001)(5660300002)(26005)(1076003)(4744005)(44832011)(8936002)(186003)(6506007)(316002)(66946007)(66556008)(66476007)(6512007)(110136005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yqj2hKnwHhIr1o0/aQYUqYk2bZpwkWrxcubDUMCXZ16UwlRsWoH/Ed/Kv5fZ?=
 =?us-ascii?Q?TsbilD54X/cQ0iPvmgntZt/T/DLVrst2EB2zwPSjWpp2B5J/+CGVG07l32sD?=
 =?us-ascii?Q?mbHrv5P/fruqioVy9PUoFAzynHm88D3aSqQqOcCESu+IWqpgKPPkBZUgz1DS?=
 =?us-ascii?Q?R2QKRabq5msmzTcXcHajAdSop5PeJx6vX602Etleylgf4Xt6+So7dRF0OMvx?=
 =?us-ascii?Q?Oj6T7vKQfpXPz6AHJxpjnQ3n7jUE3DPUoWz6kxli9rim2nUm1Ao80y5taxWz?=
 =?us-ascii?Q?fW+Cpt7Uk79M4tMk5fqmvN3l/x3GGOAGT9y3Xg45+dtTqKOP2jm0/HkTa8Nn?=
 =?us-ascii?Q?gGnbXaO3m+Jpd6BLo9kwmc9SZRKVaQ9vhYel7ReyvDUwjbVzWL3yEXYdQsz9?=
 =?us-ascii?Q?7wkCeTPPkatCOZZGCQS5k5/YRD5dRH/9hmEndK/mx9QsidMEet6VlFB8j7Qy?=
 =?us-ascii?Q?wL3/XmM8zH2BkcH0eGICJJ34/oMSkjM5ZHEJPak1cMPfRY2vPaFdlc1+Zkmw?=
 =?us-ascii?Q?d+t2UQxDlKgOJHTwpEsrDaWF35dfFS/FanI8fiu9DmbeK57m8DPxxf5qOJDo?=
 =?us-ascii?Q?Pqg+2t7i19Ig0f7hSjegGZV6tSzeHdnWI+Ec820KQZOnzV1JSn+BqRTgy09J?=
 =?us-ascii?Q?W5mBa1lEuu9rHgN56ln4xAvZ0PjygabbViDTp8juwmH4hhBUB1sdahFsJzXz?=
 =?us-ascii?Q?JtjqL4uVF7YS4VJpdPE08oDcL43YeLeW4W1hmf7FhhpJ59nDxTbWnvZcF8PN?=
 =?us-ascii?Q?hoNczkXHVlLahnhhx1FI1CxwkebhUVzSA2I6uRAujJLOwQPe9xqrTxbyJBoj?=
 =?us-ascii?Q?SQBmBDqHlXrF54vrfWAS+O3zPs3TtMepsuWasdTt0TBeTBnDm6pv92Vn2bs2?=
 =?us-ascii?Q?Lvp4truIk8zBIhPaArokr1ampnA6Hm2M6ts9atjdIr7gBdhpI/kSKV/Vp75R?=
 =?us-ascii?Q?QUZavg8ca+Z0MZU9NEJABM/lhge3lS8jBwKzDtLyMo1c0tXSUbp14ZXDqlDj?=
 =?us-ascii?Q?2245RogqbDk/al1MBJcnrtwZXnMRv4/Y0Pdyn+TKyC2+B+6h/niYrUoDj2Ak?=
 =?us-ascii?Q?oaPdscMEcGXUy6ynef6681KU5kETQP4mDRAtV9X6iIKkMd/MblHjjTX6gdyA?=
 =?us-ascii?Q?O2hA9reCBp6yNLzwqCfPtt89pooMOrOhpldy48AVL1EDBptL+uUZkMw3qHmk?=
 =?us-ascii?Q?Tc8u5WaD5vvjQid/DwjwMussm2CXb2BMXWSTQrq0/wLFU+KUF3yJ8Qg20Faq?=
 =?us-ascii?Q?/xvRIeHEVHNOUoXkMCLzFtBfR4kpDx4/gv8ykTCwm12M5cwBAC4oDQgsoEhZ?=
 =?us-ascii?Q?8BtyHhs58gKWtasNH3j3vo8iR//PZe3YnaRuHdyPo0YkHtASLBEhPuSfA1jW?=
 =?us-ascii?Q?GGfPrwqdOgbeyxwOO4M0MqUITUrpnXF1pO/crRt856n9X0y9BLJfa2cqnMfx?=
 =?us-ascii?Q?/L/8c1S4CTIxjirwNvIERfhhIyhjEl+bUoVPoAtCtm6fCO08fs/npYMc2WRR?=
 =?us-ascii?Q?i/iMt74lclcI4SB7YDQ8gHD0uMWiv3laG3f4AF0teKVRb9qswjyfPbco92Wk?=
 =?us-ascii?Q?wQGc7cRc4WMRteBiBGetsIKWAl5PAQi3szskzw5G82UsP6elkdWZ+S9f6d+y?=
 =?us-ascii?Q?Nw8HUMsZfVwtMWR7oywpDjE=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd62f4ad-45dd-4b91-3a78-08d9f6eaed3e
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 16:38:31.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsJxUx7zwD01VnyooY/MRNyoZXCUNiukUwcIt3FGLJEc1sJESazZYiGHBQwMnmEDltbW/5bK1DHzmA88s6L3OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3456
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series allow PWR_AVG and VI_AVG set from device tree

Example:
        adm1278@11 {
                compatible = "adi,adm1278";
                ......
                pwr-avg = <128>;
                vi-avg = <128>;
        };

Potin Lai (2):
  hwmon: (adm1275) Allow setting sample averaging
  dt-bindings: hwmon: Add sample averaging property for ADM1275

 .../bindings/hwmon/adi,adm1275.yaml           | 10 ++++++++
 drivers/hwmon/pmbus/adm1275.c                 | 25 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.17.1

