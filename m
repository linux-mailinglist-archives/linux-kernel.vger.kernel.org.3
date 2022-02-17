Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D334B999F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiBQHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:09:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbiBQHJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:09:14 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64E298AEA;
        Wed, 16 Feb 2022 23:09:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDTOuI0XcRSp3gw/YTmMgSZ0QR28jWshXVriliHEFVuTJ6H486uxMVcO+QFMD1++aqNs/zFCRSeeiDLJDSXB+yk4yngr+Lb68tsMLmkg3B2rJiNsY2QYqF96tdVt4PYEoCBg2vm+3OZ7zGgx+X28uAvQJ+oXdITWZo6HP4y/UPizfvsIkQaS2mFZSch1jjo8J/0oZj7yAL84euNHtQ+Q/mnh1Q2BNsrEspOo1+xLGpXvb5GwM0PXc2pWDE9OiZgrvPCH3Xbjpf/pSrS0Srz2s+bwrfNHCQ+Xe4yv+Hvy0CugcA1yqo5EhNpWyBkYrYClghdmbwSh/omVgX9HQZ2GEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i4P+uNIm4chWabTmHbGJgaH42C5w511nFJ5n7/tJiU=;
 b=R2HcvpU5+XXj1L6T+//uufHOblYAUiSFc36+dsWftFL+KoBBiuBF6CgKC1MnQ0R6BQsFr63Hck1zdUKsKYTCVJqeeV2n/ptjIWkt1uuLJR9TwUb8WgQBURNdPwWI7cYdSBj/L1KDZFFN6YurMPzTrcqkgjQhduyRBM6R5kryX9gf8RD5YW1Rd2DH3TcTtdv7hUpER/eCBRgS+680rsFhATjFTkMp0jeRa6BPnavQEbPUrGU4/3YkwOJPSqOxjSEkylynQS29Ie3a1QnsboGE1VS7ynFV4ThUzQJozKPAhsb54g2ESsAHHD33mk67JY612Sxj6MI9rqpZ9Tcwa4nqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i4P+uNIm4chWabTmHbGJgaH42C5w511nFJ5n7/tJiU=;
 b=G4KhtTkW1hfEaPV52qjmHlbgR3sAW7i7DjXHrHUVj8ySeqxRUJyiVLZXdaAZNijz9JcvPq6rg8w/8WXdfePWZscVGnccdpwd6tiMbcLwqtAVdlgC21nAFrQfJMxTEwyLEXS1VZAT/jyDnoBOupAZ8tIIppDe4qKLyjMOAqlvNvY=
Received: from DM6PR05MB3962.namprd05.prod.outlook.com (2603:10b6:5:8a::15) by
 BY3PR05MB8068.namprd05.prod.outlook.com (2603:10b6:a03:36b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.7; Thu, 17 Feb
 2022 07:08:58 +0000
Received: from DM6PR05MB3962.namprd05.prod.outlook.com
 ([fe80::54f4:cdb0:1f3c:c4e1]) by DM6PR05MB3962.namprd05.prod.outlook.com
 ([fe80::54f4:cdb0:1f3c:c4e1%5]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 07:08:58 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Jorgen Hansen <jhansen@vmware.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "acking@vmware.com" <acking@vmware.com>,
        "dtor@vmware.com" <dtor@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 1/3] VMCI: Fix the description of vmci_check_host_caps()
Thread-Topic: [PATCH 1/3] VMCI: Fix the description of vmci_check_host_caps()
Thread-Index: AQHYHs1e9+zpOx9Ht0ud6aMZ3l07FqyXXNqA
Date:   Thu, 17 Feb 2022 07:08:57 +0000
Message-ID: <7844DB64-F8A6-49C2-A0A7-0A9AA634BFDA@vmware.com>
References: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
 <7f7ad8c171566f6f8716c3451b9ddc2e83fe003f.1644531317.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7f7ad8c171566f6f8716c3451b9ddc2e83fe003f.1644531317.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e271f559-81ea-4038-dcd2-08d9f1e45dec
x-ms-traffictypediagnostic: BY3PR05MB8068:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BY3PR05MB8068503D4528D500210869C1CE369@BY3PR05MB8068.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HwqqyROlg58Gcu5CqcO8utEglTvR6EnW1VdlVK3vkjdws/NQWESIEvKu12qYuFsxuNfd1L5SZPpzA9hebs9xIuU8okruqLdBj00c2vZcZURjYIxI9jtK9l59Bg+9wtXJnPhpCFLKbnSVYVI2M6urTKB7n0er+C4MxBuZQoHUJf6/n5502OXW3bUIvHBfOHl5q4WBp2hmy1SXN9CuO52L9/AxIVy/YZhzRtUew9N4fBydNrQ41X9Ya5O4IDtnhv2qRU/etbGcKLa95o0veAITs5k5wmGH0hOIEco5ZDj755qIZGBtWpWfJwgjbgPTeP7hRKq6ET747pUoeLZxVqOhIMUHLm4JxB5nHj4Zp5OQpiF1Zr+jV/oSHzQiUPaFiJ5XaoDVEFmHql5TIc8HWl4cgNn1L2bGqzb3JVTwf+ag3Tsj2wIR1RoQ+dXNSB/DNdZFRIamZ8n3Rd60ULA8J64rZNcuGM+KsdOL2HncTm0e84IVQnIyQDJnk/4/iO5mul037tic7FYlIbWV0kN/bqbp8ZPO6OPbysddxH8Ees0oty0NhNapF/96pP9eNYzTOgOAsACRaXtEia4w19Nw3oAy3V/3jaVDrbc4I8pUov3fpdXWviytMk6KVHAlNLwnuIEYYnbP8gyc0gKxVQSr/NQXu5bPk9o7ftMvOk+FOWk5i2QOspKj/x0SLWE5/88d2cT9VlLhg39W1iJAK3fO3qqg71A/vtR4iWK4X9BeYjwE4/gRQosaPrP0Fo9bTPsCpRp4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB3962.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(91956017)(8676002)(4326008)(122000001)(66446008)(64756008)(66556008)(66476007)(76116006)(2906002)(8936002)(6506007)(71200400001)(186003)(86362001)(38070700005)(83380400001)(316002)(6486002)(36756003)(6512007)(33656002)(53546011)(38100700002)(508600001)(6916009)(5660300002)(54906003)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?73d1x2/hsdpmSGwtxF7SLm0q31bWBQ5+YSX6zs10b87Id0/s7NxutalQ0lE4?=
 =?us-ascii?Q?zyrDYl9f1kNyAw2gWP2IzY/07T6YwUSBh3X3WTF6vYNYHtOZ2+YcNO9LgRG3?=
 =?us-ascii?Q?S+fG9I4HnQeCCAfAYq9CGXJ6nAdArgxL5LcgXBoIIrW5XDFfEf9lCxhMLSh7?=
 =?us-ascii?Q?3H3EIHBtASRBlrUK3tUWO8MEWKepTHAjOUFWbI10fs1Cj1PNaElaXeJumKMD?=
 =?us-ascii?Q?ySvY6tQT3iyzxeJMTmyJpeWaSComk0WEYEVEtT2qeU9ozYmD7iGARGoCLMTw?=
 =?us-ascii?Q?vulgPxfGtjsoqlEYCDy3bEFbsiEaba0dYp8UU+W3NVwwHGljsbNrmIYKKS79?=
 =?us-ascii?Q?XoQH/ShPWHugV239pgoMb7RupMNQuSbQY8W8n2weV4j+HEGQpXNFC1RFLA+C?=
 =?us-ascii?Q?/ZHAVtaiZpl9+20ijAF5Ku1rsoAfav5F2Cu3qtwIad3gx1fKMotgM1IqY1m2?=
 =?us-ascii?Q?8zcD4TG6XUyPtwDGAGZWdbjA7irSwL/2gyy4Du4m/ssJ3jbAGDNow3wjPI9u?=
 =?us-ascii?Q?fnYiTtgSjC9ewUVjG8YI2aRhsiiVdGmQNJOT+Ro/B+rNzNOiv9A55PWJ0R6E?=
 =?us-ascii?Q?EDbAsXy+k9AznEjIp6lLp5floxRq0TfKeae9dhCCGQLwNH1g/GkTMdOQqe2d?=
 =?us-ascii?Q?YqB4HGCER9CuNtt+PrbOOCaQ5rWwZa7OaNl5+djLmfpllbf65GcazzYCT8Z8?=
 =?us-ascii?Q?jOLHHUEo0oQui4R/25VAY17QUTafeEZXimCZ1A9xK/+RUAcS17rv3X+Za3Ye?=
 =?us-ascii?Q?wLJxpR579DuYfLuTFzr/y9E8UIPzMzJuN+TDkvv/FiK2aOaYgyQbxuX3W1xu?=
 =?us-ascii?Q?5LfKkylMiHqXYqdIjT5dDMVH0qIimoWjRDuVZ9G3X51/0OVzGgTww6u9VJur?=
 =?us-ascii?Q?SJ0bHsafQJ6lgcjSvqtZA3eVDgTetUsRCDbqinjdIm5nOGEIq2zz19weCq3T?=
 =?us-ascii?Q?zXqxK4Qx1UH20exLOF/vl/ZwRKsOQLsF6js3kZW6TVV2hoK+YcyAgKi7YrQ9?=
 =?us-ascii?Q?lwUfOI2ya4x4K3+TNRTkDEQEC1zj7PseJKbZprSKcsTHGhe2uXoA0Ner77WE?=
 =?us-ascii?Q?2N2lQJAf5jSoTaFeMyTnAPWy4Sr94Lo1puCSo0gvwBXozLNGggt8LcDAEhOB?=
 =?us-ascii?Q?4bB2cPQ4FEwKZCZSAVbmgHeJMH3XODu3LDOGIJmmskTHiuOz7SHpunzw8qM/?=
 =?us-ascii?Q?rbhX0hUZcOQsCwDZLc7ux/J9BdyOGX2HFhtQWUVHEx57kBBkLaqhicFq32I7?=
 =?us-ascii?Q?ZL/UPcBoqoWzSFmT6v83nzZ7hFqjFujKbLUuip94LX3p1qYJf4FrYwKDeJPS?=
 =?us-ascii?Q?oCSQfW3Cllri8DcSSL9ANrV9enJa2Xkc14wb61OARoM/eX4z+bL5JLtcNhbu?=
 =?us-ascii?Q?0VeqUyNykCdEAw4gLdw6MmthqE0QlV6KWgdiET8rKGjqvB4hCqFyVPZwcMzk?=
 =?us-ascii?Q?gbOjEpmtH9bxfY26fCzNlDGXT4tZKPsoSrA4q63JCeeWcYP+sPCO+dD0uAUU?=
 =?us-ascii?Q?+I/PCY+pVhaBysBsJM/13iWbg8qj7auAKmi0lQNo33SWVsR3b9R7qQ8jZotj?=
 =?us-ascii?Q?mYPWGxFgRWsV+ORLyqf3tUo6+fPHjlq7+72tOks/uO9zrV5cAahYey5Z+VY6?=
 =?us-ascii?Q?U5o8BQH+a+xllaoxLaI4aWw5AlR5e7Fu+hyzaH6QGq7SlMy0iwGwRD2Xv/fp?=
 =?us-ascii?Q?v30MF0z+kfAy/B889BN6uvoNjcA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <018A86F78669CA48BA7D0168EFFD25EE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB3962.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e271f559-81ea-4038-dcd2-08d9f1e45dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 07:08:57.9027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1SiB3iCflS2JmBgzknMu+kR6fRZqwPyQa6EHB/A3WxskJmnNTesrM+MNjjol5A2zYO0fUKuH9k7bVxt3zTBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8068
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 10, 2022, at 2:27 PM, Christophe JAILLET <christophe.jaillet@wanad=
oo.fr> wrote:
>=20
> vmci_check_host_caps() doesn't return a bool but an int.
> Fix the description accordingly.
>=20
> Fixes: 	782f24453536 ("VMCI: fix error handling path when registering gue=
st driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> drivers/misc/vmw_vmci/vmci_guest.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/v=
mci_guest.c
> index aa61a687b3e2..1a1858742f75 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -253,9 +253,9 @@ static void vmci_guest_cid_update(u32 sub_id,
>=20
> /*
>  * Verify that the host supports the hypercalls we need. If it does not,
> - * try to find fallback hypercalls and use those instead.  Returns
> - * true if required hypercalls (or fallback hypercalls) are
> - * supported by the host, false otherwise.
> + * try to find fallback hypercalls and use those instead.  Returns 0 if
> + * required hypercalls (or fallback hypercalls) are supported by the hos=
t,
> + * an error code otherwise.
>  */
> static int vmci_check_host_caps(struct pci_dev *pdev)
> {
> --=20
> 2.32.0
>=20

Thanks!

Acked-by: Vishnu Dasa <vdasa@vmware.com>=
