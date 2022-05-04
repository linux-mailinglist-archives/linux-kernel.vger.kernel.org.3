Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E795A51982F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345442AbiEDHcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiEDHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:32:50 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E66D23174;
        Wed,  4 May 2022 00:29:14 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446C3ZV001423;
        Wed, 4 May 2022 09:28:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=qIOy8AJivXNxNY83OHtykq7eBzTDASWXQJqPjb6U4ng=;
 b=wQ+5tc2/DyCoLVnnNYOCdKtbnGWEGjU+y0lbJP4dBwBq5tAF/HSvZU0IBgnUkO/IasK5
 FnwBLN9PQh0M8Tia78/Ex/L0HeIF+3q83CfPMC5ZWBF9wqT1Fc6XWnluVSN/+8VI1pyh
 1PrrxOXX/z1uivkur2SO7VCcRFJjY4BXmpRnRYRrRytJwlulRmdqhUMEFTAbg/nCG6aE
 zXmfs3GZr3qkkUACk0mGpIggYiH/YHdH3NUH49nK2qr6nDaRj8KgYP2voYhrhOvfgmaa
 KL6hI+7xY19lZJ26wicHXHIbnru5ktBd09UazfCcClFfrhnOZlexgxvSwku6LqFMX/Ca /Q== 
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frv0gbc26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 09:28:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMIVj8GQXnDl/LVak6hfW86oFuE4f9OX5rh10M/aPet1TOLrSHDdsjwvBfUxc88AL7oGSEZfp0YqeNSBQXrw6opiNi0VIbDfbvGTro9wZIX/NBGsECYCZ5sHEIOEaOGm2AdtLnwTIcI+jiFKWedyLTTGN5wxl7y/kat2X57FwtpYXBs4qX/ov8J1qESsliVy6oUwZdb4VIfWIjPrV3QhODGv8IdUq+fbLVhyJZSIqex/RqgiNTvuMJ1WGbS3DfAlQyu0Wd/A8bai1tRRGmGpn5u+n2VT/sb9VK+M2wLx3vFI+itNhsuTtHS7f30j01q2dd509zfXbKDNL/jeEwoSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIOy8AJivXNxNY83OHtykq7eBzTDASWXQJqPjb6U4ng=;
 b=CzhXfgu2uUqwtuNIjH3jtwTkByNHia3Dm+3fiOhAkae0ei2odGpYL75aLoCt6eS3XNVNRDZKQOjXynC/l1uuqZlRSdZV51eDZCFOMWunye+Ffj7+l4dYzkfQpPP1I4xDOxLCp0yAJ3So1p1mCorMEZeUISDc4D1qZG/Exd0wqHJr+cUH1pVTr78YQ6raKV3nMhVvGv02Uu+SRE75RVjr2pgliGsH1+Ci6guFRY8zUPalwEi/IHORhpVytY51UpqAAyIYH4fQMj2WHOBrDT20pQ8cqDzzSK+4CJcETI2R8k+1mFGEnpMWLuF5iMuyF+JgH+TXXMT28MFygI94OxeyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:31d::16)
 by AM9PR10MB4324.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 07:28:53 +0000
Received: from AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc1b:ebb3:f408:8f35]) by AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc1b:ebb3:f408:8f35%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 07:28:53 +0000
From:   Alexandre TORGUE <alexandre.torgue@st.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: Signed-off-by missing for commit in the stm32 tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the stm32 tree
Thread-Index: AQHYXzSqtaGswd88t02XupNhEmArCK0OSBPQ
Date:   Wed, 4 May 2022 07:28:53 +0000
Message-ID: <AS8PR10MB4712B3354DACBB8A4F8309C9EEC39@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
References: <20220504072746.0f59f2d9@canb.auug.org.au>
In-Reply-To: <20220504072746.0f59f2d9@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2022-05-04T07:28:51Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=b5328239-9885-44d5-9ce5-bf09dd98557a;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=2
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_enabled: true
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_setdate: 2022-05-04T07:28:51Z
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_method: Standard
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_name: 23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_siteid: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_actionid: 76f63a44-68f2-4113-a234-84f932f7d425
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_contentbits: 0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8efe7b88-ddaa-409b-440f-08da2d9fbdc4
x-ms-traffictypediagnostic: AM9PR10MB4324:EE_
x-microsoft-antispam-prvs: <AM9PR10MB43246F6EA67A7F35BD2DF07BEEC39@AM9PR10MB4324.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h5QswtXer/NOUodrZCjltVnxvvxLN9S8snFH9yW87nbquztSJXBPxTtHWTX3Ui/fVawRCIDUc3ndU0J7gp3Ws7yIxBwMdKUbQ6BQ0u71mmJhzhUuFBPXGdxUZC4kND9wQfzub3LIdjxNQ1Y73nOi09r/VqyNwQ/fyK3uIpfKSwFQEjkzW8CvjEm1Ky2J5PtfhpKiyrIJucy/LVFyr3ZDUPYJXu0RwGZ7/4EhEt+NXL+y1fs9yfGtNtdi6gbAYXlpfBOBWjY02xW4ESy4Hn8MSFibCJ2ksWH2d9LuQZgOXQhvk9ChThdkI3w19fzoCauE956hDiU4S9CkpLT1FBnNupksMc1n1vRMcho47TQ8sC33uHztsWOBDJBdYDoxmvb/82ST80wcAykSgK+aqZVhts+OUzlm/qKhESFsxXyIVXVQxmxTri9aWBShrPWOOlNwi1kdOhfrRhagrflSaRDUxO5kuZc0ePmz5ZqtSkzQTsSDEBwIwWOmEjjb03Ys8LMSq/1p1r1oDtzaDXX72SNrQlTENp4LVOPIOI9GJnN2IF5wvAXOPfrULhME88tPHBo2tyofG3tqpFdFaizaulTe58mf+wl/MHoiC7Xw6y4e0WUhBl/P8jVId+VkAZ19t3nzM7eBUhLQMeT1SWIM1jtKLi/ktTxVE05vwDrJnma1EZIAJEg2ngOF9kP+wTu7ytLExX5Fjn0hXRLokbT9FCy1CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(83380400001)(71200400001)(38100700002)(66556008)(66476007)(66446008)(8676002)(4326008)(38070700005)(508600001)(66946007)(64756008)(76116006)(86362001)(54906003)(6916009)(316002)(26005)(186003)(6506007)(55236004)(53546011)(9686003)(7696005)(55016003)(5660300002)(4744005)(33656002)(52536014)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tBVkJvYjxggIqbDwaFaor6Tc6m0dhHgVglYf13NchGWgxp7zaHR1AavfvhIa?=
 =?us-ascii?Q?YiENEO69Mg72oMeJ6B+YJkK3H/MZvjrn/nlZHQ++1c9nE01wldztz15EaB3l?=
 =?us-ascii?Q?HaxzbCM3fcxpjzt3gnMyZ+YtZsxrhHY7BDwnZec1LifVKeEsBNqB4jlYOQF4?=
 =?us-ascii?Q?9q3IteaH0ckSDILqIOR0NQzI46GkM27sfIeX4xQdk/6LG9zgnwLiFxXvTZAs?=
 =?us-ascii?Q?DG98YDH7Vv0Cjzz0GqguxVJsc9vdBXDcHXnfouLoCPRa3fn7vtStI8JnsfUe?=
 =?us-ascii?Q?jZKsdcO1xdpZ/SHzWOD0y9/Jtu2A5h1EaoTbofoo84TBGg1JbZEhASJVf+hE?=
 =?us-ascii?Q?SAxORyN2U3oRXk6FwJUUP48j5QQsVItbqsdm/Y7hu0a7uiwhgb2kWf2Fm6dv?=
 =?us-ascii?Q?LQix2qpvs7C+kwaxWzEz8VJZH36+keZx7gSQx92snDQLN02EIGsVZrSOaHQW?=
 =?us-ascii?Q?TluheHgHpAa8NHipCMkst3u8kLZIAd613A5W56eZbypp6/dKbqGO1zj7DV0f?=
 =?us-ascii?Q?Ktxk1WrGa3pA+h7JAXcZG1i18eqxC1XNEgkunVgkA7PqidmZ2qIu4+CEhYbB?=
 =?us-ascii?Q?YbJyNYVv5DpH2y6sqKFxkzLnL5JEFz7gQKcl7/AxSdCSWoeCEIOQZsTVcB8S?=
 =?us-ascii?Q?eHYIRWpWNg+oqlDGos1dEAUk/PhftRq0uRsElBwvJcGTXWCL43qYqNvR7rcw?=
 =?us-ascii?Q?5EmTqvYRbOKLJm4wbidjL/Y7j6LzmveXvIGK4YSDjVUJs8KL1IZJj/rn6pMe?=
 =?us-ascii?Q?QLTvAOL/WAu6aGUnFGZdzsjhaG+sGn/YKWT+5kiiKSWdpQOcsRmKOJ8A6Ct5?=
 =?us-ascii?Q?hq2VsWesp+DiStlit8mKvi5DHLJrRIUVJM+LCGh2OBLMTdQVFr3ZrgnCakTF?=
 =?us-ascii?Q?Jigums3GbLCkoc95dW7vpc33hiAe/GyO4bwQS/fsrJU2CarjPAypE+RYnG07?=
 =?us-ascii?Q?TJd0KmUlhfvtYldqwGxdufq19cNbqfp3c651q+jv9AUx0inFK1vsRjq1XLYA?=
 =?us-ascii?Q?Vg9AsLr1UxBwgUiyMqfpR8rs+BAUoZ65wPjH1xN56InLPDfvMJmRDlDjbkPg?=
 =?us-ascii?Q?9bFJFjKTAU5+TZOQ0/U0gvZXY9dOc+9aKk+MSdT6RMm2LFAw5eLBnEpk2RG8?=
 =?us-ascii?Q?4Z8CbqupVjHC3USCoAzaEXaiv7r7A3tF6Uh1R8i6OrYej4myWALkJyudSlh2?=
 =?us-ascii?Q?rgIHQa4tZYgCHe/CdpPWptoQR7/y/BUaqDXA0DpsIEOeg1Mx/MAMDHsc2dlp?=
 =?us-ascii?Q?zHx+DRhl+LU+M78InrtM497w65xu+f2Rcoop1XF9a1ZX/Wfe/HRtFJ4H5ReX?=
 =?us-ascii?Q?rL4wwN0EiJrffuKmWbHiKW621mlM6ITp+PASjoJ95zT4k09JN2JtvF7jNevh?=
 =?us-ascii?Q?VM7y0EVd8dlOP48aaLi2jY5yi7UftTlk7wRdh9NmBZJIQFQ7VzD4xPdkDzm0?=
 =?us-ascii?Q?I1Sa/asWUWhPgkjF0DwlxUlSj5QRbTSZJUZWKY3zYX+qPsfNsZN/EMxKWil2?=
 =?us-ascii?Q?CwazyuzTv1ajPMJh/NwnDxDQ1Yt68oWbeXdLAhl3BVMi9befbGUVCBgRx/uV?=
 =?us-ascii?Q?UzWiXeJetorxIWbwVO2NTCyfiR+e7ubXwAEI/pybYpp2j4ov200DVIayYlP5?=
 =?us-ascii?Q?IqRu+yNQvpEpCGKqGu3gMeBWY3zl7SPN44nHMCnYka/83kw6gbNarIuDWT6b?=
 =?us-ascii?Q?Rs9unQ4gq/sjGcwBg9bCkMcp3MIclazJY/BGL6g0JV4eXkaKeRLT4GaUEu8x?=
 =?us-ascii?Q?YAvAdKGKjw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efe7b88-ddaa-409b-440f-08da2d9fbdc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 07:28:53.2996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgzwHb+dnXB4a3DxESCsTtVQNrqWvkmdxPDCllCUnuLdFxGwKt6VHQEo/6LQAE4rQ8bPMpNsTSF7+4sh7CbttA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4324
X-Proofpoint-GUID: yTelys6X-AOyqGwQ91EmGIx1jtRNSnBV
X-Proofpoint-ORIG-GUID: yTelys6X-AOyqGwQ91EmGIx1jtRNSnBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_02,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,


ST Restricted

> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Tuesday, May 3, 2022 11:28 PM
> To: Alexandre TORGUE <alexandre.torgue@st.com>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux=20
> Next Mailing List <linux-next@vger.kernel.org>
> Subject: linux-next: Signed-off-by missing for commit in the stm32=20
> tree
>=20
> Hi all,
>=20
> Commit
>=20
>   ee5596ec15d8 ("dt-bindings: rcc: Add optional external ethernet RX=20
> clock
> properties")
>=20
> is missing a Signed-off-by from its committer.
>

Actually this patch has been already merged in Rob tree. I just cherry-pick=
 it in my tree to avoid a merge conflict later for other maintainers.=20
So I didn't add my "Signed-off-by". =20

Cheers
Alex

> --
> Cheers,
> Stephen Rothwell
