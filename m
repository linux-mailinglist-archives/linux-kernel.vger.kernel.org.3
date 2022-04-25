Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E274150D92C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiDYGHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiDYGFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:05:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70125.outbound.protection.outlook.com [40.107.7.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081A06598;
        Sun, 24 Apr 2022 23:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnruAOyFIjLc3vxcHQybi/zlhse05cj6Hte5wH5lVxQz2MfuI5Qu5rZTZNXuoYImF2GQMi1/balcVawxDzehFJQQ7htuQ/pLJcUQ5ARHn5znbzs4w998pGbB5jPlf0zh2cS7fTWPzwLGv5pw8eS6AkkJs+DGlmF/coZsb4WmvzhSgzjfIdCV3U6154FEsdkE2JSjk/MlYidrewRpAQcrkCKw7zTNZoCggipqJqhzJ/XjH2nci9G9jmJ6WOgVktrheZhy8VPuR0tDaxG+2so74de/knnVM7WrFQKuG6ueMIU54qx+V85D+YsDkELX3tRdhRB9ucXFiTGD4WyM6p6Aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhHf99Tv43CQmS17yjq3ygrouZ1XXxQWnDtA5SUd4AI=;
 b=LdVhz1SH17XdG/RdhVYU7JCdoqg8lHjUjJVllKJiqEBP5UZqoCEjQDB+vc4Pk9AvpqVkNtCcSUvj7b+ek6FOn3YyYlE/jk3sYw5+W8RgdmpyuKQhzGS2bvk4RHlqhli9EYy7Goqts7ezqDFkCsvghOKF4/nrEVCpuWuwPmt5G9SKtNJNRxRd2RwX+27HBmOHj9XiQeEVdwbedLZHc3wcV5cBNp+2eNmBYcSgLfSrSUXICmhl5Xm+/eUnfFpixTOTbrhuTHfJhXo/67Vqxn2CJmAJwAgPSmwW1jeDGHmrdUg6+EAdSTFwmvHt1Kd2Fi7pe6l1xUOnZBWZ7bT18f1EnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhHf99Tv43CQmS17yjq3ygrouZ1XXxQWnDtA5SUd4AI=;
 b=ckIcfeRcKVi7w8hpFwpirtO6NtLYVeZCOOwlRvaS4x80GGPR2Gf0KnDOkBTP1lTaJBk6FpB4R/JSKnDtMF35cPrlH0l4JyU00zCcsRfzDaFw3gDF3gJUm+dpNmWDKkDwfSsTj7rjxN/aSwDJuutj3ALMzgENDIXKB8cMREK5ipQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM4PR02MB3025.eurprd02.prod.outlook.com (2603:10a6:205:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 06:02:29 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 06:02:28 +0000
Message-ID: <90204a08-0c88-6c21-1492-6a5330184096@axentia.se>
Date:   Mon, 25 Apr 2022 08:02:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] dt-bindings: iio: ti-dac5571: Add ti,dac121c081
In-Reply-To: <b657ebf9-e2e3-6d3f-e7e9-c660e860e54c@axentia.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::11) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ea1607d-cbd2-45d7-e4bf-08da26812dcf
X-MS-TrafficTypeDiagnostic: AM4PR02MB3025:EE_
X-Microsoft-Antispam-PRVS: <AM4PR02MB30257E5F2D2EA1F2948B819DBCF89@AM4PR02MB3025.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwSGMmFMtr9NqaX+LHBgCN9gu+NUv5kmaP5gMnJTW/2dFBgYst7HsH/kvqfVzuDecXttVsFqD5g/vAdLHyGw/w8FjG3BILHglYugAfCceUP4a2L0k3IwBbvZ2wfWUOkAcHckWBUyuWqsppxSMMUUEoWxghOJY7riDzwgRjfKRg58R4S/IzXioRob6dhiwI18PtGWSsZ/Tl6Ex7ZmKp7ed9zS3xCxNacci9ZzQpgoIDQkjrkfJtZo9V3CfJ0d3xK8PsUNdMDGTEvjf+NlP3Hs8qobFdUjwFThOBpM18OoyAGsuDT464uPBpG+ai9Bf+8vQLjgJvNGiUowEPX0Skus3w6/ITbbRN1cuA6lO5lSTR4yxgz8Jj4UJuHjv+L7j00jECsvC9AyDaDdkPCeIgtH7gvccEkRVl6JXIQdjciw9kWaWfQpOWVDuXNzkCbSqv6O5IL6vy5HKGHfSdfUmjQ04huxmEtD7x/LfiWPSjZt61AvuOZH2vTqGGJp++7HHX+3d+87pZB2MVVZLmdsr2BMZ+SEhNvvDYnuF49y7hD2GPCHuCO7LCyxE5vLKOBxnpPSuYP1GFpSISpsh6BhMpUTDjs5qBt6rBpoFHSw0Y1mnZCkAsKEZ8HfgRls/foPd+qrfMOagq6hgW1T0cXcuil61JD59baN4Fm8KDiknSEGY9IDE+BiQDkvvNyUtpA90dJpQ70ou558uWmiMSFacZd49THnqZ+u4i2VE4P4gMXHrWuGeTqmJwg+bMxKM6swp9p1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(366004)(376002)(396003)(136003)(346002)(508600001)(316002)(8936002)(36756003)(5660300002)(38100700002)(31686004)(54906003)(6916009)(2616005)(66476007)(66946007)(8676002)(66556008)(86362001)(31696002)(4744005)(186003)(4326008)(26005)(6666004)(2906002)(6486002)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkEzaTlJYXJ2aUpUTk04aXAwUnVZMFVFbXBZZkJsc25LdUVEMXhjTnNrRzEw?=
 =?utf-8?B?NmpSMW82V2NNQW1yMFlVblVKVGZQNGFudEdQSnJnbnEzcUg3ZGtNVFBIUytt?=
 =?utf-8?B?UHpHbUJRMzVrRzFSUmt1S3NtbE5lbEsxcUozNXFFMVpEUnZMSUhmVnJmaFZ2?=
 =?utf-8?B?bWpTdzh5Wk00ZndNL0VYNnc0cmJnQURpWDIvWkZvT1VPZ1hyaFNTWlAxb2NP?=
 =?utf-8?B?RlNTbkJpUFFERVpSTnQyUkVzZ1dhZlVTYmZDeEY4OTBhRlR2RGZ2Y3AvOEtl?=
 =?utf-8?B?YnhZVVdpN0N1c09lZzRPbTF2WnlpVzVBMlk0U1h0Y0pmOWU4VE05Q3lvR1dq?=
 =?utf-8?B?K3FvS0tJVHRiZTY4V1hUR2RMYzhMTEhYNzFkbnRIVkd5QVFNT0kwTFNWdkN5?=
 =?utf-8?B?ZlhmY1Y0MDZDRkdTTGxETTQwSVZ1T3pTZ2xvMWRqQU1PV0hMM0VEZy9PRWZR?=
 =?utf-8?B?NUl0ejZqeTF3ZU9aQUZ0eExLY09INVFPRDQ5UnFoQWR4elBxVnhHZzh1ZXNP?=
 =?utf-8?B?SVA5SlRxbzNUb0xFSXpiTnJ4aWxqN0p1L2ZmUHBCK3RURlVqVC8xUVNqc2Rn?=
 =?utf-8?B?TXhDMFhWM1hSVUZwN0NveTdyRDJKdVFRWnhOc1d3WFgvaHYxVmQ2QkVFRDdY?=
 =?utf-8?B?NEtQUFJhbC80eW1vYldFdkRoMW9KdzlRWUxzNlQ3azc5QjJCaStOd2NON214?=
 =?utf-8?B?LzhOWVUzWWYxMmM5bmZWR1I1YWI2elQ5VVVJQWhFZTZuQ0JOTEE2aWRxOXJT?=
 =?utf-8?B?ck9YQTZ0V3haMXhBQ255aGJuOFArbHZZNFBWY0REN2JYWUx6aUpCanlFcWdp?=
 =?utf-8?B?c2Y0d09nd1hsVXNrbEVuQ0kwSnhlTWlGL0VaMFJ4cEovQUNCTHNQanpOb3F6?=
 =?utf-8?B?c1NMeEplUWloU1B0UjFsd0ZweXBxZUxheDFSVExWaE9ud2huaXBEU2EycDJs?=
 =?utf-8?B?VGE1MGlQVFN2djVFME1pVlE5NUxBODNVbXBTektrOSthNkxYTVVnSUtqOWVl?=
 =?utf-8?B?aENtcmxiblEvZEluaFJTdDZDNUF0TFNVNjJnWmlGTEI3MkV3YjBBUndHV2RB?=
 =?utf-8?B?eC9WY3ZldlIySEh3RXM3SDNMYUpDTWxRc1hnYWp3TFhZQmF4Slh6djBNdEY1?=
 =?utf-8?B?aVpiV1I4bG96TzZmbzh2N2JJSHdvMTY1VlY4eW43a0thSDZzUHV5Si9zSzNz?=
 =?utf-8?B?MDkrK08yQU9hUWdyU2RGWUxyVDlUaGF0NVV4WGlZc1ppaGU4bXduampPZjJ2?=
 =?utf-8?B?MnR6TzdmTlYzdWRqcVAyTlY0bjJKaVFFMzlLSFo5QytqeERJQ3p2T0dGQlRM?=
 =?utf-8?B?eDQ0WjlkVHdGQlhhSDhML1Nxclo2Z3JaRTNSaCtQdjFxY09KOHZDRkNDeEhi?=
 =?utf-8?B?TEQreFBGdmNpcWpsL29IQ3JRZE5odHBYa0FxZmxoa2I5RXF3M0doYnpUTXlN?=
 =?utf-8?B?d0pZdVIrSm1SUS9KSW9WS0Y2SWpIUFVZb2hyQ096NzZ1NllNelFpNWlQVHZ4?=
 =?utf-8?B?ZWF5NGtXR2FYVy9GaHl4d3c3OWs0cE95VTZJOVc3MkVnTGY3Qnl1TUo5dis1?=
 =?utf-8?B?MkJEOXlCNWZEQmgzOUpWTmFYOTFHUStEbXdyMnJsS2dpaWlIM3RUOHRhQWxp?=
 =?utf-8?B?bC9qampIdG05cmhYNWp4YUZpTDA4ajIxbUF1dU93aGdUdXFJS1VaNm1rM0Zv?=
 =?utf-8?B?aTVabDBJR05TRDlnSHZvcmlRdTR3Vms2MkxjaFBnQVR4RGo3SXh0eFVIaENi?=
 =?utf-8?B?ZVh2clhTZWNIVXg4RHRmU3plOHVZSjAwNmZFcG5QSG1JOE1IZGh2bytKUkNx?=
 =?utf-8?B?ZGlYM1NYUXZmNitBalhIQU5zWE9BcjM2Rk9hejlzZ2dsK1ZrU0JXRHJBeE96?=
 =?utf-8?B?Qm9qQ0NmZkZkV2xBMytmNlRsdElXWktVRWRNUkpZbEc2NUxKRDlic1kwLy9G?=
 =?utf-8?B?cUhGZ0oraXhYRzFRamxITVU5QTdBVytwbFRjbHZtRDgzN091NXBSQjNuWm9N?=
 =?utf-8?B?QURCQXZmaU96cFpGYitpTlJWdFIyblp4NkxpR1RJUW11cVBUOG9FVU1hMmVZ?=
 =?utf-8?B?OWVOSjlKV0hGdHJuRk9oZmVidFR1MVd0SnR6MUdXQzdTWEZ4WExGelRqUlVz?=
 =?utf-8?B?TEJCQ29DVytsZlVuTkVCQjZXOWwvZ1QvVGpDK3FKdDRkY1NYSnBaSGpQdU95?=
 =?utf-8?B?TkNicE5Sd21OL1FDbDV0S2tnL2drREptcW9kR1dYQndTdmlIeThiRFdGNXpv?=
 =?utf-8?B?WGFyaEhpUVFhelZ5c2xPWlJLcU5DV0hWT1ZrcHJWU2R1Q0pOUndKU2ZIMTJn?=
 =?utf-8?B?WndIeVpoa3FMaHdmZlkyUDdFdEhBMUlpODRodVR4SVBQbGJwMk1uZz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea1607d-cbd2-45d7-e4bf-08da26812dcf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 06:02:28.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKcdA0zrguCJOmQCDVAEVnQtpNghSg6aF+McY30VSf+Ez+zo/Lse/UOUh56sAvAd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB3025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It works much the same as ti,dac7571, so it fits in the "family" even
if the name is a little bit different.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
  1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
index 714191724f7c..88298bc43b81 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
@@ -21,6 +21,7 @@ properties:
        - ti,dac5573
        - ti,dac6573
        - ti,dac7573
+      - ti,dac121c081
  
    reg:
      maxItems: 1
-- 
2.20.1

