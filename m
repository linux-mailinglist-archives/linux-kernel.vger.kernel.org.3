Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5252E53C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345978AbiETGqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345969AbiETGqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:46:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2064.outbound.protection.outlook.com [40.92.107.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD5B66C9D;
        Thu, 19 May 2022 23:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chj9pIW8niPEnZ1mo3zhI8XxkMFhbGu6JD1LkiQOlxxitWi53GGbS7dZIsTiNcVXpnboJNP6b8qcBfnZphr0tlRSvMJn7OwBoj9oegsT95TH/vzGzx2TagkV1eGKUPbtdafJRlff+I7Gqgkfb9n+LNL4wSkVMBHPLCLIGtbdiI1R5gdSQit62EcwLC3zc9pfDW5s+d6erYm2ZGpl3/mn9rWQEQkQ2PKRGcem3Pj4FpKEASB4C7WR7VOndjCT10MlGbpWoNYaXnCLIQsRxi6585Ce3HfC6Nk8fIowg4KiwvEXQJHozINjJxR0CW5iKXnpImN795kxsEZ+5X8cj0kVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XziYBHDPc+2JjPpkzPRiKlsQSW5pa9Mu4jcW/KiywAY=;
 b=IrfdSKn6mxPFamumXfKli4Zq/imWL5yyp2D26wHPp6EqSelfvFjTm30tRlPlnpEPn0qD1XLkChZJvywqtetXrj59iHb52n/7JEoJXPsP6YN4mpLAdnHxtTT4z2lpjUlSko5inHTM6QGVnQSVyCwv3ima6cddfSgTtwPfpJRBqdIwSayAOdVJ+UPdUMkUwcZ+Ygx207+mtMo4btS6DEGnkQJCGQ5botbqAbbnJb0V5AsfD2Ksf3rc1WSpzYi35NADipcfEME1lX0OJh/j/cJnMK94NdpHljFRQSItxN+Y8gv/J32Dhgw6RoZEreHWvh43o05aaA2I9CfWp6N0y3R0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XziYBHDPc+2JjPpkzPRiKlsQSW5pa9Mu4jcW/KiywAY=;
 b=uakP2cqMfJxZU0ZNLnEvgdLL1F78JINkkctk0t10rFlU2RMwfIHq4PWYvFgBADphjd4P7BWD8DJCJUszaswdgddiVYRuDus44lj39rvd6C0ZSGFTL8P8VLJ22LSk+/cLauJy6ekTwpSgW30hySpf7KIWOOzPm3lVXCXW6rFitPR9IyROTcKBwSPOKpWHwrJSNfLZR+VoilGzVEvVPWy7M89KZFTxdPYC5Vs21/Rj2h/TdhfY7R6io3aCgj7vOexoKoNSA/nLKfxMXd7wHFz7ZLIHyyp91xeKeT/zKr5wLipIj9G2p/CXxoAHuYFzH/JcIrvVViz2hX5jbHtMHYQ/EA==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by SG2PR01MB3000.apcprd01.prod.exchangelabs.com
 (2603:1096:4:70::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 06:46:39 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 06:46:37 +0000
Message-ID: <HK0PR01MB2801E9A6A53F346BC3436845F8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Subject: Re: [PATCH] USB / dwc3: remove the use of -ENOSYS from core.c
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 20 May 2022 12:16:29 +0530
In-Reply-To: <YoZpcqDCwoXIvI5q@kroah.com>
References: <HK0PR01MB280106E1D78EF51A5B8ED8BFF8CE9@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
         <YoZpcqDCwoXIvI5q@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
X-TMN:  [+gMTWbktvRIZoHg/lJ/bB9bBF08SClM3IKeGYneXxvmjFoRcguOnl8oOPqsnZBHo]
X-ClientProxiedBy: PN0PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::18) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <cdc3a785376cb702ed735d118187b446d5f777cc.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 766a88de-a875-4bcb-5366-08da3a2c7cd3
X-MS-TrafficTypeDiagnostic: SG2PR01MB3000:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHejsEgLWvt9YIPpupObRJ0POa/RHWGweyD4YkpUHnfJ0eix1xY67YHujfvpZi0jZfb2q2t5wn4AzV5G7YiDwTp5VONxHjkjnxnUlvRhYCkUMStj+FJ36ra2IWWNntJ2EC6bKhop4eSywDZnf9uJpdxW/V/OpPkmotjqPHPBDmRn6Mh/U++0QpBFx/9WW6J59PfkPiw6SXPwXdchPsKdHB61Tnds2FWXEuELhNuZwVgQ8kmRBoPgDKszH5JEACfpBvIhG9vHMA/u9R9pkT5jkn+JgKc8GQ6PUozaXX/OzBHW8XiCchSvuc7GlQWFY4PJrE2Z9UJTMA0tdBpCCHqFkMbg2isjPwdOlGWVFp9yanMhBT7MaTW0hdTKOCfT5EfY6Fad0RefwO+KXph/zpS3eTN+hwjZsVsHx0x1+KmeZeqxxovF9mNl7goeUPX86u4o2FuefQKIcaeViaiIE86Xx3AxMABGAcG/9L13Aqs5tWm5c2XKJRkC0zMYW/SS/s3oH04wK27aCGRWXLcZl1FZ2r9eQQPAwIe4vhlVz0DyMYo2nYWmdiJ1Ffw3R6OyxVoiZbP6MuN0yWJdAcJvz5P9Eg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEgwYXY1bCtKTy94dW9jaGllT0xOQlg3ZE9JVHdtaUxLcUw2R2taT1hlemdZ?=
 =?utf-8?B?dFA4ME0rZTUxS3RvZ1BxNVRQeXJXNFJEU05qKzJMVEJYWUc0MXF3Z0VFLzBK?=
 =?utf-8?B?WUVJNTdMTjh5MDV6RTc4WlgveHg2eXhkKzVnL0ZWTmxwTk1CTFpzS0NSUTVu?=
 =?utf-8?B?S3Z3Tms5R3VMOFJydW95a21aYno1SDVNVCs1QVFTbVpvMlVmMnBsTU5PVFR2?=
 =?utf-8?B?cW4vT1NQaTlBejMyc3lOeUlmUXB4czZWTlgxTVVUeUpWeXNMQjU0RXg5SDV3?=
 =?utf-8?B?elJ6SFlXMXE0c25rd2xxc1NYQVNneVpjYWFtbkM1akk4T0FTVzdYaEhtWTYv?=
 =?utf-8?B?U24xeXVCRlhwZkVMQU9vQ3VwM203OWREay9tajI2QU1BdDVKbHQ5ZTVrdkxp?=
 =?utf-8?B?cnBsRklOdlgrU2l0WnBVS0F4ZEF6dHVmK1gvRmRZK3pabFQ2dm16dVVQbVhE?=
 =?utf-8?B?dnBieVpaaE1aSW9wOVpBaVF1YmhZRzBvd3l4YmpUdU5MYzgwNWlNUWM4U1Rw?=
 =?utf-8?B?dllEbWNlZVQrOWNORUQ2dnRFelZYTzYyR1l2WUNkNUdMN2pjYlErejZTMlJL?=
 =?utf-8?B?aitQdVltalRlSG9ZRDkwZnN6T29mbFhDbkZHUGd0T1laNWNGV21RZXJYOWFa?=
 =?utf-8?B?SDFUb0FLa0tSRWk2TlBMZ1dKUUp6bU9pMjVIY3NJNUZybER0VnVONmxybm8w?=
 =?utf-8?B?RzBDU3dGNUx1bWNod0ZLTWtHc0Q0cW1GVlk2ekdnSE9GeFQwMGhoREQyM28r?=
 =?utf-8?B?ZVZRczZSSy9semw0SFVwYWY1NnNVUjkzdkhvU2FXMTRIQVRKNFlXQTVaM2Nh?=
 =?utf-8?B?UitPVjB1UnhSemJvbkExNjAvUnJ0aVpGditrTi9MVTExWnl4S1lzSTlxQlNE?=
 =?utf-8?B?SGFMOW1MbTJHVDJsck5HSmhIVmFpQmNXVlpGT1A3MW5NVlVsdXl6TDFDWWV0?=
 =?utf-8?B?WE1xYWNDckl6akpXVkgza25xS3JJNWphV0tiS0QxVkdhbGEvOHVCV2lxK0I5?=
 =?utf-8?B?VTYvYWJhVDdIZjl6RlNvNjMzalRSL05qZmN4aWVBWFJqNXdYeThCdklLOEpF?=
 =?utf-8?B?MXhpNVBJdURjTTUvNm9GYjVnTmNTeDQrbFovUFlvOHVlUFNqRDBVTEtOdTMr?=
 =?utf-8?B?M3lDOWJ2YXVORC9DaFA1OUN0OTRROVZ2a1Q4OEJnZTZpanVHRXZTMDc0c3R4?=
 =?utf-8?B?THVuQWNNb0FnRHYvZHI5ekZUbVlVaXlRN3BidjdMUVN2Mnp2RTJxMkRybEhX?=
 =?utf-8?B?OUMwblpOMzNMZlFUb0V0QS9QZ0xZQ1ViRmFFTTBHeUkwbnlTNHhzb256dkZr?=
 =?utf-8?B?ZDhKMmFGODRQUzJCTzBaR1IycU1tZm5mRnRvd2lJV2xyZU9NUHZCNDN6TWxZ?=
 =?utf-8?B?eHFNYy9DeVVOVmk4SmMwbXJWdVp6QmY3c0IrM2MzUGFpTzErZGsrWGx0TlI0?=
 =?utf-8?B?aTJtcmJCT092Wmx4MWdxclBRRlQreWtSS1NPUGNDTEFJWGs5dEFFakJ4b3ps?=
 =?utf-8?B?eUpGdkdxakFJTXptS21WR1FKM1B4bEdIbGI0TGhNVlFKQXptK2FuWVp5VUND?=
 =?utf-8?B?Q1hrbWR5bDFNRWEvV0pUTjZmdU4rY0ZZWVo5VnlIUHRvbGlhaHZyODRjclpP?=
 =?utf-8?B?OXo4d2hvbFdmYlRtZ0FhMXdzd29WbDJZbDk3azhkdzNmbmZYSUloODg2QlBn?=
 =?utf-8?B?SW5zQ3NUa2J2UFJwN210NGNUaHBSWXJCM2l2N2dZQWdpOStwMHMzTURKbWtr?=
 =?utf-8?B?Qm16NHgzTkhGZUE0NXVyNkFPZ2JGVWhZcitWUFM2UTE1Z0JpR1JuSzBNWmFl?=
 =?utf-8?B?L01Gazh2V0NudEZsWGIyUitONWo4YXZKdUFOeVlJNXVVRjJoTWs0TktXZVZB?=
 =?utf-8?B?WEI3Z09rTS9QR2ZLUzNNejlqM2E0LzMxSWlzYWxmWmRmVXpOcTJTZEc2cHRL?=
 =?utf-8?B?RVZLMDNyZkRJZHlwaDFsOTZnM2lCQjJZRVRJNkRJdUhabE5UK1paOFdTMklj?=
 =?utf-8?B?L1haS25NOHdqRjBTWHJqMCs1UjZTc3lhaHpOa2cycnpIYnowZG02a01CV01B?=
 =?utf-8?Q?OLG6Gw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766a88de-a875-4bcb-5366-08da3a2c7cd3
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 06:46:37.7136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3000
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 17:59 +0200, Greg KH wrote:
> On Tue, May 17, 2022 at 08:22:00PM +0530, Kushagra Verma wrote:
> > This patch removes the use of -ENOSYS as it is used when users try
> > to call a
> > syscall that doesn't exist. So, we don't need to check if 'ret =3D=3D -
> > ENOSYS'.
>=20
> ENOSYS is also used internally in the kernel for other things.
>=20
> >=20
> > Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
> > ---
> > =C2=A0drivers/usb/dwc3/core.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index c78205c5e19f..3c1a877d5183 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1283,7 +1283,7 @@ static int dwc3_core_get_phy(struct dwc3
> > *dwc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dwc->usb2_generic_phy =
=3D devm_phy_get(dev, "usb2-phy");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(dwc->usb2_ge=
neric_phy)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D PTR_ERR(dwc->usb2_generic_phy);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D -ENOSYS || ret =3D=3D -ENODEV)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D -ENODEV)
>=20
> Did you validate that no callers can ever set this to ENOSYS?
Yes, I think no callers should ever set ret to ENOSYS unless it comes under=
 the other things ENOSYS is used for.
>=20
> Why was this added in the first place?=C2=A0 What commit added it?
This was added by commit 57303488cd37d ("usb: dwc3: adapt dwc3 core to use =
Generic PHY Framework").
>=20
> thanks,
>=20
> greg k-h

Thanks,

Kushagra

