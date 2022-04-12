Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36644FCF87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348868AbiDLGci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241763AbiDLGcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:32:24 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204336570;
        Mon, 11 Apr 2022 23:30:07 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23C6Bhgh021578;
        Tue, 12 Apr 2022 02:29:38 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3fb861s0re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 02:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INcscFLKorAu3OydriThRwsdVZmA9QhRwPO74il+gdCMYX1TdozI3kyjOxXRlUYzmCutQ0+49REGwz3l5AeZPTHNVFiPYPnVh12oE2eCCwpzLRh6HwYSvjt0mYftoW2++M8bS+lCLnBceaYxVWhT6ejV2Cwi6RDcjcOGBHdSTR7i1gDQkwG5qTg/I+uHvxC72SX1BXNohVGETrtNM4JMV8844ecLRL+7kzGZUKncZrMWYjVvyBZWK7ZCz29LIz8flBK7howJdENPBYJawCKvsLwIrWPY1hdxmslpkweQmstNyY0NpSuMvY4ydu8mOOMLP2SsCDvQ7C+LSUK8Nx19KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hD++m9Iy0D4DS7XDH+PXWcSlqeUwhIwN8uWbohTv8A=;
 b=coODDNNqOcOx7ePDnEy7GzymYdvCNnJjIU7MuNGXilUmbCczWkxLrPRPxu7jsMNrjl2j2MVsIZQ0do0ezzI4FddTsflBYbqq33p2XNEyqQYncqzaAH1jZo3F6tzhFr+Ny12yUscX1lCRh3KAi/Q+hnoAZfNf7R4vSBp1wrgCsS4LWJtBnxCseL5NMgpxTLKhVuAR2FkjpWcTlwTR0oAnDH76NrA5aQBxI5dtWZqUaWy9PFa6ObB6UWDTYEUBn8TSXOMXAtVqTjNHszOnl0ZqMqcXr25Lgcbg594So7SmrxgKMUehHtumuu+koFjD58ruH2kJBF3fqj6hvx3SxXomIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hD++m9Iy0D4DS7XDH+PXWcSlqeUwhIwN8uWbohTv8A=;
 b=hVZLMS/zfA3waMzEQ4rthiCAZp3aa2lzzseoYnKnxKv6YLQIbI20Cmgc3ZCZv9IP5/sobYPEQ84oNkXeOb+UI4z1djfONZ8tGobUlGb318o/dElVTQ0D2AjDdnApXXE9/IZ/m9TUW5/k1R6jFAYlX+nAx40f4ZmYyeVgh79c1xs=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM6PR03MB4668.namprd03.prod.outlook.com (2603:10b6:5:18c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:29:36 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%9]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 06:29:36 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kees Cook <keescook@chromium.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: stmpe-adc: Fix wait_for_completion_timeout return
 value check
Thread-Topic: [PATCH v2] iio: stmpe-adc: Fix wait_for_completion_timeout
 return value check
Thread-Index: AQHYTiF1o+UEAcyHdk+WlnZwOcLGqazr0M0Q
Date:   Tue, 12 Apr 2022 06:29:35 +0000
Message-ID: <PH0PR03MB6786157EDA63137DF0071D1F99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <60e67c07-7e40-4187-a90a-1be9acdfe757@gmail.com>
 <20220412015547.4137-1-linmq006@gmail.com>
In-Reply-To: <20220412015547.4137-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZWFhOTk1YWQtYmEyOS0xMWVjLThiZGMtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGVhYTk5NWFmLWJhMjktMTFlYy04YmRjLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMjc3NSIgdD0iMTMyOTQyMTg1Nz?=
 =?iso-8859-1?Q?Q1MjQ4MTY3IiBoPSJVd2xhVDRpUUlQcGlCTHBFN2hMZVVBT0dUeEk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUNuYndLdE5rN1lBUmlsT3BpL2c5WElHS1U2bUwrRDFjZ0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bed5031a-c838-4978-f36a-08da1c4dd05b
x-ms-traffictypediagnostic: DM6PR03MB4668:EE_
x-microsoft-antispam-prvs: <DM6PR03MB4668355D4809048E305F8FC999ED9@DM6PR03MB4668.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hosHcJ4QfS1WBImAHccmjG+tH+TBZAh0dG98fQpEVc3VSa95+hBPXvZ1KJutURZGKmBTeyAIzWYYBFpcgCGAI9IyE6e1eWoMnodK6xQXT/ReQyvqttIml+IJuL1wOiXFZd46vwnVdRiFY3pLzpO8IwG8/hXF/wKGNKY8TS6A415DdYG8gAuEjcKsRentBjnH9ry82dmbXL0P49Zz8Mk0gLJ8HpH1BRFAj+99zG/DiJ8iwFs3WcCYHsf3yEUJ8SYnUsBZg++gXGSlE12aV9539b7QlQRDwY/Bt3DT+GbHRpYwwCBuHZOAXcuHKat9iIFU7/JjtGSHQsv8y+OcxU0wlHWH/I2UdJBelb8Jb4xuum4D1Z88desn/rXISFUB0mx5r9MFrQE20LzgCSKkDKjYAkxtBdjWJgomfPXplxYyZcc1tXIbf7NSGV9wlSMAImjaCe/czMtQh4qtvW4EtufqM0D2USibqcDVfo5FLwzPx3gB00F51ZN6dEauxZ0JH8NabV18lCkuMHondwvzuO48l4huITW65+B5jr7CtMTk9PWZwDouYz6bhTeNrgMMdhOLGtqGjyUMVPT09Ip1lfBjSiWppUHoqPFbtJ2Y3eLLWrQn10ozhfDVYmgsEYjbz5g5DbXg1Q/+rqK7UWwwu+6kHGzjINYvY9FYDlQG2atnxhzvVJbHNOpsCLfb6+13uXJb1NbxBQuz76QO2BqG+LQykoutUxfQ20cY3itV1eSIx6w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(53546011)(2906002)(5660300002)(7416002)(8936002)(55016003)(52536014)(6506007)(7696005)(38100700002)(9686003)(33656002)(83380400001)(122000001)(316002)(110136005)(921005)(76116006)(508600001)(66446008)(186003)(8676002)(64756008)(66476007)(66556008)(66946007)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WQp8fVLK3SqdLMpYDrks7KC4dIjx0tZ0WV8kHBBAo+j54jyahQTjNrJl/R?=
 =?iso-8859-1?Q?B3i/Q6yfo5Jxm40W5Bm/x5pwWo0PvptWye5sX7DPssmGOXurlyCIBhs3t4?=
 =?iso-8859-1?Q?qg/GOqfVsFS4DcRZ8DLOe3s2+LEbATZiTnkY4e4SxQ6qzwlnr92v6Uz1gN?=
 =?iso-8859-1?Q?I2/I3J/3mOhiDrInjNR91WRBqUXU+Akv/rkEGQKPiYNyuzFeDi79jQTzqA?=
 =?iso-8859-1?Q?Lum24dEfEiJhm+MmY9FS6BiYLsSqBbJJpgTLX7nCSCpJmXA/si+zQTHUH3?=
 =?iso-8859-1?Q?pC6uQdOXY5SeaFW/U2j2PFi8KFB1pSpkzvFzoI/QElk2k11Mx9Up2z9COu?=
 =?iso-8859-1?Q?bEQIJkHdJ5TkRVmKu0hlu3ZHytcEEnqUQLJU+q3tGZ1Fic56TwdUREX1vn?=
 =?iso-8859-1?Q?mmIAk/qFf7M80uepkZ3uMlJ1/8w+LYziBj0IrM8Hg9nLprkqmFaX1Fm6Mu?=
 =?iso-8859-1?Q?RhStQr04xPfVdmxjucybuuRXqraV8H9Dh/7M9T8wA77zzTI54BA6ENyy8V?=
 =?iso-8859-1?Q?wbLkEXZnTn4sHUkQW/N34xIVd+qPkW3t+M9xylsPzDzTETvpUOneCBeY0L?=
 =?iso-8859-1?Q?FGJrI6fVe6aGmIz6KtWoETjtswz/uoG3c9018zvo842ZlUBGYwjPhvNItx?=
 =?iso-8859-1?Q?81zU+fwobhIQ/iirwym7DRNZJO9dDfh+T0MZyUQcACACicGI/TAeJPrid3?=
 =?iso-8859-1?Q?VgIBrYm/ks3DB715u1FYC5z5uDcG/WyfX9wQaITEoN3Q4xrpLLa/N/Giy0?=
 =?iso-8859-1?Q?2Uw7qEyXIcfkCGBGjn1wemuaDI2P9dmHQ7wa43m8rxYsix4mBMopLAqUZ0?=
 =?iso-8859-1?Q?jifvvLjcL6Bxog07slOKmLqxFMIQCM302WoE1who+7bQVE4FUWfRK51UL6?=
 =?iso-8859-1?Q?gyvBCwSVk3ehkYEO/17Qq7Oz977gt0CZTN2mXPU5ULQ6QEDQIAQ19OsCnS?=
 =?iso-8859-1?Q?f+scvx2UnbYE1eAp4/ha/lwrlp2+khhTZf3UgDgdwPUe7XqIe6i7OZBnCV?=
 =?iso-8859-1?Q?tNHdCTijLv06J/C/KJZ1brIlqhl7sS+LVahkEYaX9F6Xr1rgiHvuAVTiN3?=
 =?iso-8859-1?Q?wx5s5g+ZhQgacJvOOGLXusO8+FWkCaK/tQ1fIRwnxlJqCFCOZqubbkHfP4?=
 =?iso-8859-1?Q?Zf0/xQxLKXelWgAywYRCP7DbmE2sZmlBfv+HgyFXgDSp7IZv41MUY0SwdD?=
 =?iso-8859-1?Q?2jfuYYGWaftB7OvAHoctxthOSf4XACsVPLTZFZLHgcc0pT8eaH4tFfvFVi?=
 =?iso-8859-1?Q?gH4q4aapzNS6X8O+bh3rNEk0yokwWdYQN0qcUf9ctghqK46hLWkkPWFkQR?=
 =?iso-8859-1?Q?V84bPIqMD9zSKbMo86XeaaWgvArcBhOrN/mg2ahUevH+V2+OWuM8TE1fQ2?=
 =?iso-8859-1?Q?GEnNDJKPRnHPwwpae6q2Q874xth3Cp5EZ9YGCQby9XS/XheWFEraBi7h/W?=
 =?iso-8859-1?Q?DECbovdpzCoqGGf/YLvthCg+YobAVWSPp99I/2IlXYbLaTN4x6zUkVI+DO?=
 =?iso-8859-1?Q?iTqyOO2oDbiDaYoUi8ljFZjwNEkSOK4uPcKuRG1gdSrhaTHusxkXBDxpE/?=
 =?iso-8859-1?Q?DyrpOGeu/Jc0FlGFlHyaWQraca8ZSMwUCYUmq/CZrmxHb1v+UFkb6ESaR+?=
 =?iso-8859-1?Q?awGllI7K841Yl/4KwoGztnU97gTXDiF1QdYrm9B3eb57g1hAIFicBJ4DoS?=
 =?iso-8859-1?Q?upJcB0l11BcmmJw0YQ1nzjn2m+H9L5DHX8ShsmbmbaQPCtIQkcoE54OcEA?=
 =?iso-8859-1?Q?/J+U3bqroRcycPTzMxUQAo7JnWemTAOQABcYmHtGSS3p3rjPej8xBpfZl3?=
 =?iso-8859-1?Q?gHacjTkGriDsYuFC3WSMHP6S/GMIxNfvlo1aVHZN45nOUxQebLg0R4A2JB?=
 =?iso-8859-1?Q?vg?=
x-ms-exchange-antispam-messagedata-1: 86z9b6/0D6DxkQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed5031a-c838-4978-f36a-08da1c4dd05b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 06:29:35.9155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iofzOJS0DpTY6wNU518RITv2UhyGXBeP151bHYHHvMGu2TyoDxsf92JIuq3LKQSeGS//rL4oi0oQ7mwhbmCBLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4668
X-Proofpoint-GUID: _7exyP1clxiklKtYsOj9Rs_-SweLKupd
X-Proofpoint-ORIG-GUID: _7exyP1clxiklKtYsOj9Rs_-SweLKupd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-12_02,2022-04-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120029
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Miaoqian Lin <linmq006@gmail.com>
> Sent: Tuesday, April 12, 2022 3:56 AM
> To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Kees Cook
> <keescook@chromium.org>; Miaoqian Lin <linmq006@gmail.com>;
> Philippe Schenker <philippe.schenker@toradex.com>; linux-
> iio@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v2] iio: stmpe-adc: Fix wait_for_completion_timeout
> return value check
>=20
> [External]
>=20
> wait_for_completion_timeout() returns unsigned long not long.
> it returns 0 if timed out, and positive if completed.
> The check for <=3D 0 is ambiguous and should be =3D=3D 0 here
> indicating timeout which is the only error case
>=20
> Fixes: e813dde6f833 ("iio: stmpe-adc: Use
> wait_for_completion_timeout")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - Fix same issue in stmpe_read_temp.
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

(I guess the subject also needs tweaking for the preferred format)

>  drivers/iio/adc/stmpe-adc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index d2d405388499..83e0ac4467ca 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -61,7 +61,7 @@ struct stmpe_adc {
>  static int stmpe_read_voltage(struct stmpe_adc *info,
>  		struct iio_chan_spec const *chan, int *val)
>  {
> -	long ret;
> +	unsigned long ret;
>=20
>  	mutex_lock(&info->lock);
>=20
> @@ -79,7 +79,7 @@ static int stmpe_read_voltage(struct stmpe_adc
> *info,
>=20
>  	ret =3D wait_for_completion_timeout(&info->completion,
> STMPE_ADC_TIMEOUT);
>=20
> -	if (ret <=3D 0) {
> +	if (ret =3D=3D 0) {
>  		stmpe_reg_write(info->stmpe,
> STMPE_REG_ADC_INT_STA,
>  				STMPE_ADC_CH(info->channel));
>  		mutex_unlock(&info->lock);
> @@ -96,7 +96,7 @@ static int stmpe_read_voltage(struct stmpe_adc
> *info,
>  static int stmpe_read_temp(struct stmpe_adc *info,
>  		struct iio_chan_spec const *chan, int *val)
>  {
> -	long ret;
> +	unsigned long ret;
>=20
>  	mutex_lock(&info->lock);
>=20
> @@ -114,7 +114,7 @@ static int stmpe_read_temp(struct stmpe_adc
> *info,
>=20
>  	ret =3D wait_for_completion_timeout(&info->completion,
> STMPE_ADC_TIMEOUT);
>=20
> -	if (ret <=3D 0) {
> +	if (ret =3D=3D 0) {
>  		mutex_unlock(&info->lock);
>  		return -ETIMEDOUT;
>  	}
> --
> 2.17.1

