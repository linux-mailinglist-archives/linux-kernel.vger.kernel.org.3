Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C54C46FD59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbhLJJJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:09:13 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:9882 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbhLJJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:09:11 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B9MwBeu030774;
        Fri, 10 Dec 2021 04:05:17 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3cuu2dhyd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 04:05:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWZi8OqtyXM7SHCKodBLZUAqx+g+HyO4wQ0NsJ7R6djWwwGACE544OjXZlYZJX2Kwu5p3eClQtQ1T6BOlGhhud8LW9hg6EtC7QE4yROtGZkMDvXc1Bw9qOSF1sMuhsoiz/495DbqfcT6zIzOIz6sAua4SyF+jQ0fgghSm/VvXfSeWIqD9pLdr8KgixPkYE8uHe+Is+lUbo1RhNeIozS/r0ac9DTJbTpPO7mIx7Aso7Q6T9cwx00O0ov3XDW/MnDFI0nKWcpTgqJVjL9GdMuEkoiZSX6Aug4AypF8nJkmPQ5c9e1WEMKAl55Av9sWcqBbwAzedsGtmzbsKrulsDYnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5HBiTv4jt+J2GmDIDcR7gqKV7QRL5nJatOEcQz6SXE=;
 b=GYXloi6eMRvJSlqeFJWF31GfJ4k9Jzo6o8mU8pZi/kEGqSwKbQvvn+O/qDgVkyj7L1ndCnXvhhcpe2Vni+HM9v0M2IY6wugZUDTgevZGcplfrznVDJ1lF7d/3E+2sHF0G3UD/lyyouOm7GbfevYB4RPibJ5G48klICQ7rNgj/MdIuXavqSY8fEN0X8Ha5w84Tb4vmUGiXdssZSt6RqSn7ZdQd6HpjekIQwiTgiThXwIGt6/x8S+yA0qoGH6D1ADULw4onpjuW2K/W5bNhm3CzNjXPZMuHNeoLa9dnfCy/uxAgiDTPWPDOPp/mABU547X+IYPzuXxfJLRQfinatv97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5HBiTv4jt+J2GmDIDcR7gqKV7QRL5nJatOEcQz6SXE=;
 b=plTn0x3LVkVCHD99kwGZA3uPc93tzbYmHNlKtftfq+nHd+4UpHSNA6H9JnLlbI9bjP8XYQ31PEcaGedFHVv71whr6MfMCjTfORBlyy/bTvAHiPtXzBKAwm1pZdh9WvTINSubuZpNAdIQhwe0ATF9xzi2t4dgd5q+hjgzyAbZZE8=
Received: from SN4PR03MB6799.namprd03.prod.outlook.com (2603:10b6:806:217::7)
 by SA1PR03MB6641.namprd03.prod.outlook.com (2603:10b6:806:1cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 09:05:15 +0000
Received: from SN4PR03MB6799.namprd03.prod.outlook.com
 ([fe80::389e:1793:98e4:407d]) by SN4PR03MB6799.namprd03.prod.outlook.com
 ([fe80::389e:1793:98e4:407d%9]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 09:05:15 +0000
From:   "Chindris, Mihail" <Mihail.Chindris@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>
Subject: RE: [RESEND, PATCH v6 1/2] dt-bindings: iio: dac: Add
 adi,ad3552r.yaml
Thread-Topic: [RESEND, PATCH v6 1/2] dt-bindings: iio: dac: Add
 adi,ad3552r.yaml
Thread-Index: AQHX6r9H97OwZzV1N0a8StCfthzSbawl/oqAgAVyznA=
Date:   Fri, 10 Dec 2021 09:05:15 +0000
Message-ID: <SN4PR03MB6799D9A834144D6E00187B3B99719@SN4PR03MB6799.namprd03.prod.outlook.com>
References: <20211206163529.3528-1-mihail.chindris@analog.com>
 <Ya6DhTiU23k839M0@robh.at.kernel.org>
In-Reply-To: <Ya6DhTiU23k839M0@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWNoaW5kcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy00NmY2ZmZlZC01OTk4LTExZWMtODQwZS05OGU3?=
 =?us-ascii?Q?NDNlYTZmNDhcYW1lLXRlc3RcNDZmNmZmZWYtNTk5OC0xMWVjLTg0MGUtOThl?=
 =?us-ascii?Q?NzQzZWE2ZjQ4Ym9keS50eHQiIHN6PSIxMTAxIiB0PSIxMzI4MzYwMDcxMTMw?=
 =?us-ascii?Q?NjM1MDUiIGg9IldRcUZBVVRXbDRmc3dzRDF4d0RKb0lLZmdSQT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QlIvRm9KcGUzWEFTeFVoWjRkNnMvNExGU0ZuaDNxei9nREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c583de64-5c27-4575-12c6-08d9bbbc2e47
x-ms-traffictypediagnostic: SA1PR03MB6641:EE_
x-microsoft-antispam-prvs: <SA1PR03MB6641D53A9AF351C6331623B199719@SA1PR03MB6641.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5psoc989rQCz1k9/uJfrrlH0b0WYr2YHXWec1GYFyyaw3nrjZ4kpLdIbYj7unKbE1dAjtITDT5s5XiVkPvkNcfCetnjGNmIy/J0LAS7OHhRxR+UUFejqS07SHz03+mAx1+RaB/RFNvT+vG2DL3lityLExMWT9hRxbmWqrtXZalOs/3v4aHVt8badXYLZWvm0nJr70unVqjSmwZPq8odMhUaRObRjhGEuepX/9ve+L+PIrAI5vnN3rVQI/IKyRS4x70hvXNMylIFrytPKq0YREiEjn2/QMbMmNDy2tH9MlXVSIdaT/qmU1EEhdpqMtNbkDymYHXZuMqg+lDF9oBf9ky/eFIApk330vQWaggZBdeGx2IgT1QzG7RZJk+F5z23OVk/l/aUz3t/TyRzAbtlgEuY8GaKf5Mesi9oGdTvPSF486mfRgPknVknhZLPqF2VByeppt06+cWYE8OJ899oqWua7YrEXxJoiQzdfILu4r2aVYeTJXAJYS2gXpRntUtJUuwTF2OZkmBy4d4Jf7LGq/YY/WKarHu5JSvqu93EIitjRcnwhcRkrVnRil6hd/xCeozojIMQh0o5ktbGahOgtLt8AgSvK94Lq5JxxHp2lGtyN3px+6m7o700HDewWtnvNBW7X1zys7XOnYK/42ewGX16OZJBTjGVl3zgC6ens3Eab60zdzbQiTS77x+voGK3Fznq61+gbJgwFEvZSOUk08A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR03MB6799.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(52536014)(8936002)(33656002)(8676002)(5660300002)(2906002)(66556008)(83380400001)(71200400001)(122000001)(76116006)(86362001)(6916009)(38070700005)(66446008)(508600001)(38100700002)(54906003)(107886003)(4326008)(6506007)(316002)(186003)(66946007)(4744005)(66476007)(64756008)(55016003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gs8secX5oyJ+Pgdql6ndk4bUROEU3d7Z9KotI7CXL71Vb8um1/qhqqVdzRLG?=
 =?us-ascii?Q?qKjuWXPDaxuFX/PHDVJqTL/I/jobw3WU9E9MDcGKrPzbqoyczf4HHc3/6+RK?=
 =?us-ascii?Q?25e6FYqMyssdGT1Cvp8qe9GL5DUmNGS5E3kIkbU9nfnAujX1+4g8OF0cnINe?=
 =?us-ascii?Q?UE9KfxOu4QzI+aoCcc/El5V/bBYkuDrUOeo/N3LklY0cN+UQQjYNtDAWHQlv?=
 =?us-ascii?Q?ITtKc2WCK2jGWEz0BBUmCbZSjlareaTQzTyHJMNP2AP0gCEVfg59aOh+9J+t?=
 =?us-ascii?Q?TULcTZDnJXnl9P6X6Im18A1yBvMAtfds9+LuP54NYxsG1xOXyd0YeEZrGdDP?=
 =?us-ascii?Q?qM5rEzgl+1s01YOF/mTgxh4w6YceoKz7qrhWJXaH7ARvCV138XTO8Icnl2ez?=
 =?us-ascii?Q?VuNpYAi33Wfqd33k0hmW1UMj2ULmzNyDwFQkNZbNJm3x6Z19Kuxmnun2AW3b?=
 =?us-ascii?Q?7rM9yWJ4dMAXS2Zs4nMDtqw/ibxvCvgtAaYkEI8ApHrvFEp5wkQw43Z96XLI?=
 =?us-ascii?Q?McB9ZtE8+ZWKpdv7+lfvCVs6SX928tMyPgGxiY1T+77dRulmFtjlWyAgRjpA?=
 =?us-ascii?Q?RJVmz7xC4CUH0R+IaH43h4H0QtgWtZub4dhX6cnLH9qRe6TRVyEB2nMY5N4O?=
 =?us-ascii?Q?O1v3ZInIYVxYpMLhnEGGRHuQOZVRcltYkJDSndN+lJ5vTTQ/CmoeN9Ju/lcc?=
 =?us-ascii?Q?BqICBhh3fNK2g5xLJB1iJSd19LzwdenoGvbD5AvxzNpEcZMgPnZG2VMze8pB?=
 =?us-ascii?Q?kZDM7XEot8kmU4v5Z6O2DBXpycU29SHaNzSWUVVw/2x8yxAmh8dTgVLSM7wT?=
 =?us-ascii?Q?gIb63b8AwG1EtM8pDttOuI385S3/8i3pAKjUhtHaVkxADb0neNKcid48+N9b?=
 =?us-ascii?Q?HXZpJ33VGqg/QLkuCkPbThxVblvW9G+h0RGNGZ2K7Sc0tmSLBhnkEy/LohRn?=
 =?us-ascii?Q?HsRObzfFaiJJqwLF9oX7cFfa6Gji6VRS8TuqvYfWV/mWIgZ9ir+ZYmbRKifx?=
 =?us-ascii?Q?o4Q0oUONGgd2k/XIZk9jF1JO5NbNHbLGZBLMkltHGGjNxZD9OyHY5h3PH9hc?=
 =?us-ascii?Q?8ESdCYQUJ7j0oyFJcCiWkxvG19xLyTCTjq1QHCE4hKO4UWh1SKeycwxikJ0z?=
 =?us-ascii?Q?qy+cNvgso5KxRB9S6UcIz8Ki47c2y3LTaRU8WVA5E3WifJtbBrwR/tl3RyBm?=
 =?us-ascii?Q?J+yaw69odCV7T2m40kJRfl1udkTPxQElSXH7Li3adwaCHRFj54aEPpOevMhS?=
 =?us-ascii?Q?/o13FLhveh1mbE5c3pvv7hsjPAMxQ3AOCCUKVbkLCZv5rKKekU62+M+H26fM?=
 =?us-ascii?Q?f6g0zVBaVtXcEc9DyAd2Rp8DIeP0SAPzsjl6K5rtWsP3qGdEdczgb7FHD7AK?=
 =?us-ascii?Q?IVyBXuJCb+1931tJmezGUGMSGCW3kr4S/90/fqA33QnO7p7WFRNBIPEquNKO?=
 =?us-ascii?Q?hCzk/jVvZJpNC/TeTqiH2tzfe0HZG/LUZyD4dEyfoB583l+c48OgL8KzLgce?=
 =?us-ascii?Q?xGva8bWh/7kakz/wLpEcoW42MQvfwVhdtFG+bKudIXmWffsA13OUSpFcToAJ?=
 =?us-ascii?Q?/TcZOU0L/3zZx2aGXwrQpKncA/nMSU3LnTHa04Knf3cEiUtqghSAhCsl1nx7?=
 =?us-ascii?Q?APSuTu7oO0R8z5i983XtH2aYVFssawK5phFeEdJB4WJx0qq6BTKWiKxr5zXS?=
 =?us-ascii?Q?cZ/UXYp/qPXM2SeOqTVkOK8YIXHuvS1uD9D1JzFSENZ9KtzuqQVEPCBoQzS3?=
 =?us-ascii?Q?3jpBjMwOdg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR03MB6799.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c583de64-5c27-4575-12c6-08d9bbbc2e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 09:05:15.2270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/sB0+xt5hXuHRdyN+rsZXTPDJKzz/fXt+UZvap6IkpqLJqeSN0kHppUoGixdOoU5EqCGRzBBkJ4XXWYhxZ6oDediPFnzf4X4Qrt68ljPnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6641
X-Proofpoint-GUID: 6tWXapfHaJtm0ntAaDSb6HUgsUBUZqXm
X-Proofpoint-ORIG-GUID: 6tWXapfHaJtm0ntAaDSb6HUgsUBUZqXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

I will fix the build and update the patch.
I have a question below until then though.

Regards,
Mihail

...

> > +
> > +      custom-output-range-config:
> > +        type: object
>=20
> Why does this need to be in a child node?

For an ad3552r or ad3542r you can setup a default output range and a custom=
 one (only one of these options is possible). The custom range is configure=
d with this child and the default can be choose with the adi,output-range-m=
icrovolt property below

The adi,output-range-microvolt is described bellow for each chip. I couldn'=
t find a way to put it here.
Do you have any suggestion?

Mihail

>=20
> > +        description: Configuration of custom range when
> > +          adi,output-range-microvolt is not present.
> > +          The formulas for calculation the output voltages are
> > +            Vout_fs =3D 2.5 + [(GainN + Offset/1024) * 2.5 * Rfbx * 1.=
03]
> > +            Vout_zs =3D 2.5 - [(GainP + Offset/1024) * 2.5 * Rfbx *

...
