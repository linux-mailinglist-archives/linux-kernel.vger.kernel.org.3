Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD84544DCB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbiFINfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbiFINfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:35:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF531380;
        Thu,  9 Jun 2022 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654781701; x=1686317701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EHrL7vdjA+gTrMqYt5KpbVFVUUkAfxG0fDONEvhm24Q=;
  b=Ciu0i5dLDIwvpaagarzDe+NgSmhRM7KVfI5evDWrfrwlhx0oPJY5bLLf
   HThR/LTmVVE2sESuQex2uyZCGFS+lqebcbF9eMnkok24Gixp/PMqG+bNU
   Utd/SBNPo3FCYXtkWBDeZQ75ymXuR+bk0fCVyoM2K2VXmrooDnCpZyEuT
   tkTsFohDaHqXFserDdlpJBgNfY+Zh5YsXbfgClE87FNeSd9T9Om9cZUYG
   oj67qRIQXfTQVeY0726aHYYxfUXEAj6FZXAcAme9qLQrZ03GD/PWhvJyN
   raZ1vdfvplfqaNBJUl6SzNRnBBv9pTI2zs5pnGB/kkyrBr3JmTh80/g0M
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="167760555"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 06:35:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 06:35:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 9 Jun 2022 06:35:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2q/sL/sQal4FKVAwMhMHgQjgExSQTiK25wXVGLgP5YW+UUJk8oKI5Eox0fsfgVLVbqIBoVR+/x2NiQzpUXw1ON1WH/eNgDKctAahVlU1EO5lq5e8eY0q+Mk4RqV9TOzZfPc3yuq6LeR1iASr6tA9GT9F91iBqkkTaNuGIxmuE9/FpJXz0DOO1dqraOg4IZs1YheqgoWttQV3YYRYA67dvVQDZikq3pTGAnfz/TkvM+ZSO8XTOHXeUfNeCp1ZMqJmHpIfYaQfG5W8mJ9xc1qqB+eu1wI/zWl1phEKb66hiju/etUPzZWVmUWthfB1+8ahH+wWDhKXeP+z6xsdJhMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6W6KkRwtNK0biPbvWOB2DwqMff1MzJ8tg2vQRm0Qd0=;
 b=nsO1+k2eVaAokWGGZjjncy02bmpuXTJl5kV+DJdNSVCGXH7hcj/55SA2ZeTJ67bx4vdqs8myiSiObUQSVaoB3bvREHxVfvPqKueu+aPknV5+ykH1lRats6U97OVdb7oslIixgEAXkwHCaQqRuZZNBd7MYhUrnY5JAn7llTWNw6KAWicsA8wo8EXr+OM3m+W02BlmbgDFZsWTap5yLHmsDbTVJ/dY4H/ZqQxck+L2cEuE70X+QdoPvwK67yAxHj6Zy5dly71KlkImHS6W7P2sUKYY2FSRDIwUBs4eBh4+DdhpVOuzyxLt1FPYVJwnvocXmz3GSBhx1ONw5jCGpdGXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6W6KkRwtNK0biPbvWOB2DwqMff1MzJ8tg2vQRm0Qd0=;
 b=VOlZfelxrZ4Hj+ZCAT2wo49gSBLNHRyD1yBn1uZkSt+uJqAorsjhPaimcl+s+zhESYYPoHkcPJDTpDiyDoHgdoEb+oAbGoSkLeKIrlHqn72mDossVt51Did3elbzCoJaqa/OmFJZo9DzoRupLSO6QYn8j8fLXDHaql37mfw39T0=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR1101MB2109.namprd11.prod.outlook.com (2603:10b6:301:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 13:34:48 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a%7]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 13:34:48 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Topic: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Index: AQHYen2xLy/v/QXVdkSn5wTBKfw+1K1FH4sAgAAIsKCAAGfPAIAA9k/ggACQC6Q=
Date:   Thu, 9 Jun 2022 13:34:48 +0000
Message-ID: <914DED99-7DC0-4014-90D4-4CC54C99CAEC@microchip.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-4-kavyasree.kotagiri@microchip.com>
 <9cf14336-16c3-5df5-b235-3f988d8b5151@microchip.com>
 <CO1PR11MB4865879F14D49AF7550C2D1192A49@CO1PR11MB4865.namprd11.prod.outlook.com>
 <c3a17994-72dd-8b64-4ddd-9deb3c793e24@microchip.com>
 <CO1PR11MB486542298A4208581AD8DCBD92A79@CO1PR11MB4865.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB486542298A4208581AD8DCBD92A79@CO1PR11MB4865.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e2f8f24-7b47-4ee9-5e98-08da4a1cd2bc
x-ms-traffictypediagnostic: MWHPR1101MB2109:EE_
x-microsoft-antispam-prvs: <MWHPR1101MB2109F2FB0C1362646E41FE7B92A79@MWHPR1101MB2109.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3PCv0aCiVPr4SRX/LRMSboCNkzRBm5fJTuoF2hzT1iKLu2DKRNpEubtGTBQnQBy5ognMFRdU/iM5SKSglyOUVSTkwiMN0Bd/MTfKLeJpJrVBC9STYyq4ZnwLj8aRFjB68K7Vxlee2oi9JpZCqp5+4itGQlpZ6tUkpW2xBB3ttS6EpXYYL37WAK5mmKMHWiT+ufc5es1bz3qGZts8+aKsaDjjZ04aCNerBRRZ7w8kdhHLQ9OGxLWExXMbHRki3MdndTLwor7ODRrM0MfdoPJCcE27AkCFtkvpKm5BEs4rmgOM2/mH9/0pvif460bt01PVrpanDI8AcariRPZc3AevUuTOE9+T+Pg0AneSlO6W9Q9mnK65ovD9m/3mqtfOdnjp6htwnCUfZMx8Jtk7RBWO+Ilkgn46Nti9xOF6Qc+k+w1/vKaqhVL9+lUVb6yAPbGCg549isMMZCPmG3oLzOeJ87PUY0BZOIuwyMQlhmMZOMwR1R1Wo4vgUoDQ41lAcOAY2GI+qL/ojVaLc6ndCNviIEnTn5av0baEu2yFhF7oYQu4BysLUEzrRQjYd0BmEFAr1nOn13BzSzB7ZdfaLNi6POVa2ObXT2Bv10n6dpZavnq6Jc22Xc4QwGEFU3Bn2BLjOueABfUNmNonT2UcB3MK7KCkAicygt6rIKtRcZrZArxF7U8KyjCRFG6NFATDV/5J16O63zImLbTWHlNtWjKctkD3h3Fsba90wRJM9M3yqxaRt8qwbDuKG6tQjb+4EiqvbQIph+Qj2Q798i874+nLAlz4QyvDDIiNWdPm8FvnvOeDYBhoXp3wC2Apfo3FMFNdYScIiFqIm7xHMzzAn6NFzouOR3UmFHzTwauV66Kk5MftHaQIa6UYfmsCxygvgd9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(45080400002)(76116006)(8936002)(36756003)(66446008)(66476007)(38100700002)(91956017)(71200400001)(6636002)(37006003)(5660300002)(38070700005)(316002)(6512007)(54906003)(122000001)(66556008)(6862004)(8676002)(64756008)(66946007)(6506007)(83380400001)(2616005)(33656002)(508600001)(186003)(966005)(6486002)(86362001)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JfbHQOBClnppSUCPvrBhwhdKwSlmTLcN4Mm9fKsMWZukeIxgZ6Y9Y2agAbjd?=
 =?us-ascii?Q?0K4NUPl7trAe/tMeJVlMkkBUn3tfiERmMEO2Lkecm4yTUjbu4EZOoNgpkmfM?=
 =?us-ascii?Q?G6n/sykiI8SxSnHu/a3wgZRaFb1a/P9TzPPYq75MGhWiGBoFVOmz5vV2700E?=
 =?us-ascii?Q?ppKqaiHeNLqb3HK3eCpbVoyJlwR4cu92BUcSYSM4xk3YCNRrbI1Vh9ff1C1i?=
 =?us-ascii?Q?QkMxPAeayhjBcUqoUc1Dlc/HzyJuH+xJzrQkLXK3feXcGll8aGDCRWFC1eoX?=
 =?us-ascii?Q?mHOHM49FUTlxEXskJSnLtEnWonXv98LG7cEYCmdIyEt1ZnQL0YDwIbyy8TAT?=
 =?us-ascii?Q?ETFKknehT6bQLMbxYQa/HfOWQAwkDx0LWLKyKD5p/aqC9GmtzOQqCJBCTk6w?=
 =?us-ascii?Q?FeUBWZ5bIJXKejvGTtzwQ4DL39/IMR2uHDdFkJrhej7MPDSj2tPTiZokZToV?=
 =?us-ascii?Q?YJocn52m2dYdmTd2hLqD7C2nmYqbVxmKqnbvUbo1c+1iiNHBYI5qp0T51MI6?=
 =?us-ascii?Q?9FaUrvjFn1tPGBlzDoLdTz9n7aL/x3SnfRvN0ALFnkj49iVY1xw+OAfJKQjY?=
 =?us-ascii?Q?RLpR9yNF5EsCPlGm8sdp6IBtJdsDtoEDRR3+1BGSuwsQhSX/FF+6uBRJ5JVQ?=
 =?us-ascii?Q?Ytk9+bDt5oRR+qqlIW4AF+A/IvecmKSllkLDeZ6oDUrxcX4WttGJLB0sD7yA?=
 =?us-ascii?Q?iId9GAdbk5g5GRsaX6qca5MGntS2PLpyYVShNGPCbajP6Q5KHpp9R20p5a6d?=
 =?us-ascii?Q?43+LY/M7K63wtrW2/5wwgKzS2TwleOafCkJywykCX9MiL4HyR7v1x4tSflhF?=
 =?us-ascii?Q?ooKPpTwEOXGdfgsfFwBm9RzvD6wR1qm77cP+CNdpxPB/DCrE0Mbc2R3Yizkn?=
 =?us-ascii?Q?5AJz0NxWpngYQp8Cw/NYl2Jn3x7jnhcaRukhlvX9iadS6zX9DQQsc+MCEzLu?=
 =?us-ascii?Q?PN834fkxBvoWDJlqJo2RcRWGyhhrq8dzcScmLkaCOly+m85EbllDFXmtrVAj?=
 =?us-ascii?Q?IX/WvFJ+3g2lPgHmxZCB4BcrZV732sKHwZgT22eftlqQsvfjuefcL2Hu0wEI?=
 =?us-ascii?Q?Der1tC801FCZRM0ZWW8+xoEGUtS8gS/AbF2cEFThqPjj+/APEAA4ir42lDjN?=
 =?us-ascii?Q?DEb9iAGu/dVtW/0M8sa0w/JU03BO9J8c636vgZvKA4SRp/3qASlkXgOrUWA7?=
 =?us-ascii?Q?jUb98AtZumxgSvxztP9JvaJfQHm8zQVtDzfD7CBMunnC1vrMFDYvY82Yf0Mp?=
 =?us-ascii?Q?bcn/nqx2ocaRMsOuq4nuFZWGtnxw6dSIslmiPGAvqHmxSNQN5+XRMt4WuOdj?=
 =?us-ascii?Q?8ca2mgXmID4dprSmxFdwInI6orSLGTV12CZNjPFA7gmRgj9mZcnzh+rJC0Ga?=
 =?us-ascii?Q?Xq3lZ9qlDioZEjVMP5ttL8SBii/QsBNz5e1WXWV2iPhuYwoXAmWvKoXa2MGI?=
 =?us-ascii?Q?syv6Du4KckHqAjqflT8/L3SLI1KTf/5ka2iZi5Y6RF7oTH8ttg0ByTQbaVVL?=
 =?us-ascii?Q?kpL/QWTUvtA4TM4RMCUMes1KJG+ERr/yjCkxUvjIFIH7U/20g8Rl26mvn5av?=
 =?us-ascii?Q?IAWjSg9m9NJ+FvBF/MV2MzYe3aJduy4F803pk3vaYgJIzByKcep8WLiGp5fm?=
 =?us-ascii?Q?9JoGjgKt1UgK25RfiAQ6hKJDSyIJq6TV6slWDDiKcyWB2y6vE3Q/D/RATYHY?=
 =?us-ascii?Q?p0++hTY0pxsFnUTIQv2/J8dWfwyvZRICAmrxqtaW4xtQlhgSrUnK0+SZc7Oe?=
 =?us-ascii?Q?iznPlWryrvCXkT6w9uFcsCOk8mt9hHeTKnYv5BIrYYOD6QsIWJ1L84gXo2ev?=
x-ms-exchange-antispam-messagedata-1: YR0ncbHCukVSPYleAObN2OurZD5rEF/G3xdNxV5TFjmfHrsjS8k6EWTf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2f8f24-7b47-4ee9-5e98-08da4a1cd2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 13:34:48.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asT1HpOi36+jhgRwxPhgaBe9OpjP6K6RPWIj+kaaAXd8k5QITt48JDeHlt6TZcPIHStODgphCz1fefkaU1rafn5Z7BZs4BOEfKEbxlcnYHQTY8Gw/bi5wpaARkoD7jxe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2109
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> LAN966x SoC have 5 flexcoms. Each flexcom has 2 chip-selects.
>>>>> For each chip select of each flexcom there is a configuration
>>>>> register FLEXCOM_SHARED[0-4]:SS_MASK[0-1]. The width of
>>>>> configuration register is 21 because there are 21 shared pins
>>>>> on each of which the chip select can be mapped. Each bit of the
>>>>> register represents a different FLEXCOM_SHARED pin.
>>>>> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>>>> ---
>>>>> v1 -> v2:
>>>>> - use GENMASK for mask, macros for maximum allowed values.
>>>>> - use u32 values for flexcom chipselects instead of strings.
>>>>> - disable clock in case of errors.
>>>>> drivers/mfd/atmel-flexcom.c | 93
>>>> ++++++++++++++++++++++++++++++++++++-
>>>>> 1 file changed, 92 insertions(+), 1 deletion(-)
>>>>> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.=
c
>>>>> index 33caa4fba6af..ac700a85b46f 100644
>>>>> --- a/drivers/mfd/atmel-flexcom.c
>>>>> +++ b/drivers/mfd/atmel-flexcom.c
>>>>> @@ -28,15 +28,68 @@
>>>>> #define FLEX_MR_OPMODE(opmode)    (((opmode) <<
>>>> FLEX_MR_OPMODE_OFFSET) &    \
>>>>>                FLEX_MR_OPMODE_MASK)
>>>>> +/* LAN966x flexcom shared register offsets */
>>>>> +#define FLEX_SHRD_SS_MASK_0    0x0
>>>>> +#define FLEX_SHRD_SS_MASK_1    0x4
>>>>> +#define FLEX_SHRD_PIN_MAX    20
>>>>> +#define FLEX_CS_MAX        1
>>>>> +#define FLEX_SHRD_MASK        GENMASK(20, 0)
>>>>> +
>>>>> +struct atmel_flex_caps {
>>>>> +    bool has_flx_cs;
>>>>> +};
>>>>> +
>>>>> struct atmel_flexcom {
>>>>>   void __iomem *base;
>>>>> +    void __iomem *flexcom_shared_base;
>>>>>   u32 opmode;
>>>>>   struct clk *clk;
>>>>> };
>>>>> +static int atmel_flexcom_lan966x_cs_config(struct platform_device
>> *pdev)
>>>>> +{
>>>>> +    struct atmel_flexcom *ddata =3D dev_get_drvdata(&pdev->dev);
>>>>> +    struct device_node *np =3D pdev->dev.of_node;
>>>>> +    u32 flx_shrd_pins[2], flx_cs[2], val;
>>>>> +    int err, i, count;
>>>>> +
>>>>> +    count =3D of_property_count_u32_elems(np, "microchip,flx-shrd-
>>>> pins");
>>>>> +    if (count <=3D 0 || count > 2) {
>>>>> +        dev_err(&pdev->dev, "Invalid %s property (%d)\n", "flx-shrd-
>>>> pins",
>>>>> +                count);
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    err =3D of_property_read_u32_array(np, "microchip,flx-shrd-pins"=
,
>>>> flx_shrd_pins, count);
>>>>> +    if (err)
>>>>> +        return err;
>>>>> +
>>>>> +    err =3D of_property_read_u32_array(np, "microchip,flx-cs", flx_c=
s,
>>>> count);
>>>>> +    if (err)
>>>>> +        return err;
>>>>> +
>>>>> +    for (i =3D 0; i < count; i++) {
>>>>> +        if (flx_shrd_pins[i] > FLEX_SHRD_PIN_MAX)
>>>>> +            return -EINVAL;
>>>>> +
>>>>> +        if (flx_cs[i] > FLEX_CS_MAX)
>>>>> +            return -EINVAL;
>>>>> +
>>>>> +        val =3D ~(1 << flx_shrd_pins[i]) & FLEX_SHRD_MASK;
>>>>> +
>>>>> +        if (flx_cs[i] =3D=3D 0)
>>>>> +            writel(val, ddata->flexcom_shared_base +
>>>> FLEX_SHRD_SS_MASK_0);
>>>>> +        else
>>>>> +            writel(val, ddata->flexcom_shared_base +
>>>> FLEX_SHRD_SS_MASK_1);
>>>> There is still an open question on this topic from previous version.
>>> https://lore.kernel.org/linux-arm-
>> kernel/PH0PR11MB48724DE09A50D67F1EA9FBE092D89@PH0PR11MB4872.n
>> amprd11.prod.outlook.com/
>> "previous version" meant for me this the one at [1]... Another point tha=
t
>> the versioning of this series is bad.
>> The question was the following:
>> "I may miss something but I don't see here the approach you introduced i=
n
>> [1]:
>> +            err =3D mux_control_select(flx_mux, args.args[0]);
>> +            if (!err) {
>> +                mux_control_deselect(flx_mux);
>> "
>> As I had in mind that you said you need mux_control_deselect() because
>> your
>> serial remain blocked otherwise (but I don't find that in the comments o=
f
>> [1]). And I don't see something similar to mux_control_deselect() being
>> called in this patch.
>> [1]
>> https://lore.kernel.org/linux-arm-kernel/5f9fcc33-cc0f-c404-cf7f-
>> cb73f60154ff@microchip.com/
>>> As part of comments from Peter Rosin - Instead of using mux driver, Thi=
s
>> patch is introducing
>>> new dt-properties in atmel-flexom driver itlself to configure Flexcom
>> shared registers.
>>> Based on the chip-select(0 or 1) to be mapped to flexcom shared pin, wr=
ite
>> to the
>>> respective register.
>>> If you still have any questions, please comment.
> https://lore.kernel.org/linux-arm-kernel/PH0PR11MB48724DE09A50D67F1EA9FBE=
092D89@PH0PR11MB4872.namprd11.prod.outlook.com/
> To avoid confusion, I stopped continuing with above patch versioning(mux =
driver approach).
> I started new patch series in which I am configuring FLEXCOM_SHARED[0-4]:=
SS_MASK[0-1]
> registers in atmel-flexcom.c driver using new DT-properties, mux driver a=
pproach is no more followed
> as suggested by Peter Rosin:
> "
>> If you are content with just programming a fixed set of values to
>> a couple of registers depending on how the board is wired, some
>> extra DT property on some node related to the flexcom seems like
>> a better fit than a mux driver.
> Based on your inputs, I planned to send a new patch with new DT propertie=
s
> introduced in atmel-flexcom.c driver rather than mux driver.
>=20
> Thanks,
> Kavya
> "
>=20
> Thanks,
> Kavya

Hi Claudiu,

Please let me know if you still have any comments. If not, I will send my v=
3 with clk_disable_unprepare moved to goto and some minor fixes(irq flags) =
in dt-bindings.

>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> static int atmel_flexcom_probe(struct platform_device *pdev)
>>>>> {
>>>>>   struct device_node *np =3D pdev->dev.of_node;
>>>>> +    const struct atmel_flex_caps *caps;
>>>>>   struct resource *res;
>>>>>   struct atmel_flexcom *ddata;
>>>>>   int err;
>>>>> @@ -76,13 +129,51 @@ static int atmel_flexcom_probe(struct
>>>> platform_device *pdev)
>>>>>    */
>>>>>   writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base +
>>>> FLEX_MR);
>>>>> +    caps =3D of_device_get_match_data(&pdev->dev);
>>>>> +    if (!caps) {
>>>>> +        dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
>>>>> +        clk_disable_unprepare(ddata->clk);
>>>> Could you keep a common path to disable the clock? A goto label
>> something
>>>> like this:
>>>>       ret =3D -EINVAL;
>>>>       got clk_disable_unprepare;
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    if (caps->has_flx_cs) {
>>>>> +        ddata->flexcom_shared_base =3D
>>>> devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
>>>>> +        if (IS_ERR(ddata->flexcom_shared_base)) {
>>>>> +            clk_disable_unprepare(ddata->clk);
>>>>> +            return dev_err_probe(&pdev->dev,
>>>>> +                    PTR_ERR(ddata-
>>>>> flexcom_shared_base),
>>>>> +                    "failed to get flexcom shared base
>>>> address\n");
>>>>           ret =3D dev_err_probe(...);
>>>>           goto clk_disable_unprepare;
>>>>> +        }
>>>>> +
>>>>> +        err =3D atmel_flexcom_lan966x_cs_config(pdev);
>>>>> +        if (err) {
>>>>> +            clk_disable_unprepare(ddata->clk);
>>>>> +            return err;
>>>>           goto clk_disable_unprepare;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>> clk_unprepare:
>>>>>   clk_disable_unprepare(ddata->clk);
>>>>   if (ret)
>>>>       return ret;
>>>>>   return devm_of_platform_populate(&pdev->dev);
>>>>> }
>>>>> +static const struct atmel_flex_caps atmel_flexcom_caps =3D {};
>>>>> +
>>>>> +static const struct atmel_flex_caps lan966x_flexcom_caps =3D {
>>>>> +    .has_flx_cs =3D true,
>>>>> +};
>>>>> +
>>>>> static const struct of_device_id atmel_flexcom_of_match[] =3D {
>>>>> -    { .compatible =3D "atmel,sama5d2-flexcom" },
>>>>> +    {
>>>>> +        .compatible =3D "atmel,sama5d2-flexcom",
>>>>> +        .data =3D &atmel_flexcom_caps,
>>>>> +    },
>>>>> +
>>>>> +    {
>>>>> +        .compatible =3D "microchip,lan966x-flexcom",
>>>>> +        .data =3D &lan966x_flexcom_caps,
>>>>> +    },
>>>>> +
>>>>>   { /* sentinel */ }
>>>>> };
>>>>> MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
