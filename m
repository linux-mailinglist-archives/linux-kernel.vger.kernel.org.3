Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8354CC067
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiCCOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiCCOyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:54:47 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2217DE2E5;
        Thu,  3 Mar 2022 06:53:58 -0800 (PST)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223ENPw9015915;
        Thu, 3 Mar 2022 09:53:37 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ej7p0e74g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:53:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmQbm0AMEI9YvZHo+Nvzw/iKmWWlbg8UcGbDBVILbOp3sI0Zm4rCiKY5sUV4UpiBuoKv6tAgoadvgKihqivSXM5ry5PBxw+HKlHp9mhLjXmk4oyK7BywCrJQHH8q23wbL6zbL/5PI+EjQ3nS+yVBaoxFuADov03fRHVQDCluQ8HWfq5H7vsIfNiac5Ha1rA/Iz6mI5n9+ono6WWfhSZ7IP5o0AtpoBO6nD12RBEZmYHGZ5FZUX654I/S3JGTDeNHqCVB7NudtsFFmhA75lP/azZkTmIcW4TGTA+uU+QDBGpvUckmzuiO8GZfBVlT4SEuu1mz2f/KOFaL2r6N6FjSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfrU2c+z383bm0sIqVn4HDJdygjWBu6/Afy+14uwgAw=;
 b=mapRbOr8ICtfHN/WNWnQ6hlxi7GZNoM53kXBGx0ZvDzfRriy9k9cZV5ong3zwoTC61c4qhD4z0jg5OD+zo6t0Kgi75ShrAdZs+j77pjS87hsy3EqwAME2ZpbkoFLk9uMYKIXj2PvOQKioHWbg8884mca7Kx/cwbHtp1d5pX2V6RLWITZDPMzAjc60uoAmJOC1x0Uu55B6Zy3E0+VW2EUrlriz3tr8fFe1Gn5JWnyT3J+HFv5SXxX+03QZKZ6E8NyzAk8vln/ATIoLQoHgT1Nrlh4E9fslEMHoJLWJpC2pMEAVdjAEkPuT3AoHkuoJ0/5kW0Y6MLLsn46s+EoCsO3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfrU2c+z383bm0sIqVn4HDJdygjWBu6/Afy+14uwgAw=;
 b=jFel/Yaxuvan99G7NaAl9dWVFbSUGvbclQU8Yjqy87fZW6iG51jPej30oka5JyelTjdx0lquxoerlujOIkEi9k4TSwpqhIfKH8Cke+/pP8hXXbSZc9tuvbK5Phgs1wSkWATuiWOL7gMOZI90RK4vJ8/Ag/t6JrCfVWb5a2uqVkk=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM6PR03MB5148.namprd03.prod.outlook.com (2603:10b6:5:1e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 14:53:34 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 14:53:34 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of device
 properties
Thread-Topic: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of device
 properties
Thread-Index: AQHYHoXV68rIrkrTnkK2YIykAkr2haytxoqwgAAJrICAAA9wkA==
Date:   Thu, 3 Mar 2022 14:53:33 +0000
Message-ID: <PH0PR03MB6786318C7588EE3842D2183A99049@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
 <20220210135522.26562-3-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB6786304A458CD4B11AF5C42699049@PH0PR03MB6786.namprd03.prod.outlook.com>
 <YiDJTZECF9FHFIS4@smile.fi.intel.com>
In-Reply-To: <YiDJTZECF9FHFIS4@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYjBlNTQ3MDMtOWIwMS0xMWVjLThiYzctZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XGIwZTU0NzA1LTliMDEtMTFlYy04YmM3LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMjMxOCIgdD0iMTMyOTA3OTI4MT?=
 =?iso-8859-1?Q?E2ODYyNDA1IiBoPSJleWVVRHlvc01XeGczZHl3VlBiL1llVzFJVnM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURGSFQxekRpL1lBYmhocTVuTjgzaHh1R0dybWMzemVIRURBQUFB?=
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
x-ms-office365-filtering-correlation-id: 155be5e1-86d5-4c54-a6d4-08d9fd259720
x-ms-traffictypediagnostic: DM6PR03MB5148:EE_
x-microsoft-antispam-prvs: <DM6PR03MB5148F882E5908AAC23457D5899049@DM6PR03MB5148.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPswIsT/64+eC7EeRkqIkC8L6CB4JovqGMPeU3LZUFMr7G7SdaTYYLFBIED3n8T/EOjuKW905d+x6/orTdSPawhHRyT/PRRnkKvsRmTxTRN4jXtLCpfFVwa4J1TFIbwvrdCKtywRlI1yerdP3uD3yPgGcN89WG/DIJRrJ+TarfDomdOlNBo4joBoz79xBh0sVgxFH5ZuSLYWX+XTURf2ol0FF7ejIUaXGFzyLtFX82C6VBqX0Bb+n/7q+UC2TJMldTOSsK6iJfokSOXz1z1E2tWL5iHt61WBAni9xMX79cLRQFJ6XkOlxn4ngHCAvCHIortBOH+9eXvOOGRU46yLGskpataGbVJGMQhvY5m4eSkeuWBjpZj5WizHoeITbCnRTSFDwP4W6TwfHnvdit5287uk5wjqDqHBkEEnIny6gHAOKHr5rqKSoIZeYC7UwGdqmYNjsoZ7mlyslobFS1OW/jUHyoylP/KkLS8OXsDe+tHumXaWmRsisn0c5HQ9TicmnB4bOvJj3ZkYF1wigNrqcckO91L7XyqbmJ5xGRup+sE9aCccJyr/cVX28j8yxmnhl2z+ExymlPHISUlllc7exxcizyo+b7QsDmq1m51uQD6D9Tc5lzGuhTKmYuY94J78mNCgGxRp0OyM+DWNFXBgXnA6+SUXSoLIm9ShpxuSn83h1pKA8ca4dK+c8x8ptxtazvIhObV0LP6Yye8OPsWDPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(7696005)(6506007)(83380400001)(26005)(71200400001)(53546011)(186003)(2906002)(8936002)(4326008)(5660300002)(8676002)(76116006)(66446008)(66946007)(66556008)(66476007)(64756008)(52536014)(38100700002)(316002)(38070700005)(508600001)(55016003)(122000001)(86362001)(33656002)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LC2YrcjU8PdQdWbe8w7MWr6i0iVHICwG71Vu6U2ma+u95bqvNjv9Yq7/Po?=
 =?iso-8859-1?Q?gjxWrscDMl5gMhPxIBF99kCjiqK1dQz8lKoiy20GiQ5eRp9GyOkaNfBaTF?=
 =?iso-8859-1?Q?JAzUuBQ511P+NSTTDbLiS/Eg5Rv7zmB9lRbpYpNJ3H9pgRupSsy3Jhm7T2?=
 =?iso-8859-1?Q?goxzRh8ckHKyHMKvKvJ713oRdJvx38UpgzSBnH4qdkZ4MpZWCdb4yJaoO9?=
 =?iso-8859-1?Q?y6RVb9r5glKewIXTl47uNHTtArP+gyDskqHmhkEM9hxfoq2n6AcZgpTr4H?=
 =?iso-8859-1?Q?/BVr03HwBpjPk44+rijwznekErqkxWQDFeSvWo0k0pzFvgpRClij3mnth8?=
 =?iso-8859-1?Q?meCCOcCo6kerdkQ6/V3HD8XQKVRJ5wxJGToWoLqwNl2X5QYaDKb59WNwBm?=
 =?iso-8859-1?Q?XVOFUSQLKGf+kObwiAQpqcEPvuUIoSAo/2wDcgkmbfkkSPKh+WrvGYtmlZ?=
 =?iso-8859-1?Q?nZUjnVPH1FABaj107w7EezlCTsq/YV4nhsS4osKiMB+Z4h9ba9cvC2rRoK?=
 =?iso-8859-1?Q?lpkDhCoERgj9vRBGBXiU8GwN7ENmOsT6ntHeUJHKw7Dd1/X5NJQtv8f+9e?=
 =?iso-8859-1?Q?0cBdkFD1ukj6Mrj2nu78Md96FWBrg+uszuSf8tkZaFE/AjNDydEOLugz/G?=
 =?iso-8859-1?Q?7F0ojnjdVUJGa2MCec6LE2wL232H6dThFFSvqq/ypEmxeJpj6YU3r4Qs88?=
 =?iso-8859-1?Q?jgPNFx/iLSCw5CFd9p3OW6p8Y4a+AeQeB9U/VrruJyIpL5/HdiNCYnBD+4?=
 =?iso-8859-1?Q?G3lEG9KVK8rxIuBU5n9thIw0nTfcz5dwiPZwEkCERKLmatIlyETe38r9pn?=
 =?iso-8859-1?Q?7yk6tAtILBSA7E08NzvQK8v5P+EcgOEoroCV72MW7F6k6ZH18qJneC+jBh?=
 =?iso-8859-1?Q?8iZIUwhNN9S0l1hIfQxJeIusMlnjv8N2NblkuSfjGUIoy2rrfGAcyAIQ2l?=
 =?iso-8859-1?Q?uDZwW+NwdEsjUyUlQNdZgvkvmLBuusqZjnEY+nHFAw5vupdfYUdBUhwLxs?=
 =?iso-8859-1?Q?+UoEza0U//bvQFRtjwqZhtxFADVow14O7V8GkYWSOoMGWNaqnehLuvaADB?=
 =?iso-8859-1?Q?KJUE+UR9amUXkGLMWjtr0qhJSHl+8g/Q0bwml03Vpqrt1q/Ogscvp4BFo8?=
 =?iso-8859-1?Q?0Vi0Ox+fkxhWnt/OxHYpZVsM3ccz/YQ6Vu+yR8+1TnJqFL9QDFvnpnqqy9?=
 =?iso-8859-1?Q?3Kb9hnbzY38IVlARKJWZy8E64bSD/baQ3tHLFTa+HIyrOa61yPiVZpmO2y?=
 =?iso-8859-1?Q?YsIFBLQcvqf7CkM7sonA6tGhNPQkY74PlT/WeVNO/V7LtgNoV2h3wiMXNq?=
 =?iso-8859-1?Q?QN0rRll7SudBDEEZdyVyK2zMTHS6CFgl9cayOEeP0nsrWXGNVfo066jp+f?=
 =?iso-8859-1?Q?uP/gKgUER8AIPZiAWjvbzXS0+CaKXmask6Dd9FqX15GSHwj8hbjLJBJLkT?=
 =?iso-8859-1?Q?eWK0wPC/FVKF0WcIvrr1/JmX00mdxT1+ZiiHZOJFAS8WuZtg8EI9e3oujL?=
 =?iso-8859-1?Q?8h2etl6nxpN1+Y7n2t8XLXaw2lngJXifrMvEPjkCaCm3hp7EBetwtUx9lW?=
 =?iso-8859-1?Q?5dNVnjBgU4nn/Pdqks0umbmbMLsJgjSARXRx/ncHzXmOPOj4geSY6STOaP?=
 =?iso-8859-1?Q?8jANT1XY3COhDz8mWonToDFDtiCbVI21/5faZ4yDRwIgB2/wcrEHqAKg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155be5e1-86d5-4c54-a6d4-08d9fd259720
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 14:53:33.9815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zk7E59E2/aOcOaiBXU3jkObms0Bvk3kDTFpjPyT7GlzRvxfDxrXtwA61+fVMb58Up/pjn7COYw9bT12dralRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5148
X-Proofpoint-GUID: oT6DWOyvFWJprpgYZgJXGTy6eW1jGtET
X-Proofpoint-ORIG-GUID: oT6DWOyvFWJprpgYZgJXGTy6eW1jGtET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030071
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, March 3, 2022 2:58 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Jonathan
> Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>
> Subject: Re: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of
> device properties
>=20
> [External]
>=20
> On Thu, Mar 03, 2022 at 01:31:56PM +0000, Sa, Nuno wrote:
> > Hi Andy,
> >
> > Good that we waited to test this patch. The fundamental logic
> change
> > for fetching and writing the custom tables are fine. That said, there
> > some issues that I had to fix to test the patch. See below...
>=20
> Thanks and indeed it's a good news that we caught a bug beforehand.
>=20
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Thursday, February 10, 2022 2:55 PM
>=20
> ...
>=20
> > > -	phandle =3D of_parse_phandle(child, "adi,cold-junction-handle",
> > > 0);
> > > -	if (phandle) {
> > > -		ret =3D of_property_read_u32(phandle, "reg",
> > > -					   &thermo-
> > > >cold_junction_chan);
> > > +	ref =3D fwnode_find_reference(child, "adi,cold-junction-
> > > handle", 0);
> > > +	if (ref) {
> >
> > This is nok. It needs to be 'if (IS_ERR(ref))'. We then should return
> > ERR_CAST() in case of errors inside the if block. As this reference
> > is also optional, we need to nullify ref in case we don't find the
> > it. Otherwise fwnode_handle_put() breaks.
>=20
> Got it (I hope).
> Lemme go through it again and issue a v4.
>=20
> > We also need to use ptr error logic in the other places where
> > fwnode_find_reference() is used. Although, in the other cases
> > the ref is mandatory, so there's no need to care with breaking
> > fwnode_handle_put().
> >
> > After these changes (I think the changes are straight enough;
> > but I can re-test if you or Jonathan ask for it):
> >
> > Tested-by: Nuno S=E1 <nuno.sa@analog.com>
>=20
> I think of v4 where I may add this, but still would be nice to re-review
> and
> check if I got correctly your testing report.

No problem... I will leave the setup up and re-test v4...

- Nuno S=E1

