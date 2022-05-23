Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3799C530C36
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiEWIpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiEWIpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:45:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5B3B6;
        Mon, 23 May 2022 01:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpJ6TvVp6G7QnglLWnBpoHVqMOKEg6thgeXfKmi3m0SlKSIk09lRTGvbkVEGqu4q6CuEIGyQW+9RHCMaEceiaG7PRO96sFbYmE/kGRXJ0eMmsKk6Lad2wvzMx+/rZCWOx5t7R49vMmxumyYeMo17/NNMs6Wt+8LO5MET8lmofkkGl6GYaUo1hJ1LQvZbOu53DKx39K+Yrqv4kbZX7IKU/T6kanoGnNRbo8n92PbOLdCYG4WYEP2M0+An1UMKP+BmQ6XnwUs7qe1czLNSk+SEwO9YWR7aHv90t9iUAwFbHWI7uAOCyxxSfPy8/zLuBmU9QgvwKW5xAC4nYRLwGrDxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8NaZfv9g1t1SM+/N1F3hLZ71WT31oQu7+zPIgj35PQ=;
 b=bBbgSsqg7c+h2w4VsvdQDvxY9K2ELVnyDTO5UQX5WdtfRLzp/OuZRehsW/MDD3ZaUnndFO8Q5TpX3/0GhganMuuof7fATgbDfdRrYbMhvbjtoO2W/3XLhl11Qbxem90586dfEJHbitT8UIwcELdUuav6hi+sp+pTk5tZerpI5mWSYzSEBfBIxykgqJH+aSqejaRtstX662nEFufzCQ9u2gJjpK9GbnzqjQLrSgxMn7FQrsquBEQtojw2AFdYE8OXo7cq3s+/J8tnsGCegRPvHhb/N6AoOFbrOiVnfBESss9wwjjISor2wXIvvdGkyBVZnxidH2+7Ob9dGrPAwVTyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8NaZfv9g1t1SM+/N1F3hLZ71WT31oQu7+zPIgj35PQ=;
 b=elaHU8nke54MIWmJn3gbMZHgk7lLFL2i5d5pLLxTHlk5dzOLjNC3nghgVcYu447NKzCoyMioo4l5mHn1EIydOtWc4likdD4PbmHorRUh7LUf/TwF1jJR0BxHBM2tNCHoUiv4dBH9IU0Uaufnt3/sHD1Ub4SNdZqIaIlEBp7D5nJX7DyuSuDz4NyNX25vAKET8zGwpiEE8sAOd07YGubLqDo722Snxqxqwt0J+tRbVaaX2fRNQojHk88n0doFvOybkOIRX62qry3xJHUEps62CJYRMVV2MLvDcz2nwfhiSRsCIYYbsvbhjC8CrvrDikd0ZihyJjbW+OVqxjMDoIjS4Q==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AM5PR10MB1746.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 08:45:06 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7479:206e:9e85:df85]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7479:206e:9e85:df85%4]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 08:45:06 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/9] tty: n_gsm: fix user open not possible at
 responder until initiator open
Thread-Topic: [PATCH v2 1/9] tty: n_gsm: fix user open not possible at
 responder until initiator open
Thread-Index: AdhugKHBS/ZYBUgVSK6qwAv9Jt72TQ==
Date:   Mon, 23 May 2022 08:45:06 +0000
Message-ID: <DB9PR10MB58810877B0B37B6212471415E0D49@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-05-23T08:45:04Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=ff95e4bf-bd7d-49f4-819c-0307094518f2;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67236463-9e6d-475b-eed5-08da3c988948
x-ms-traffictypediagnostic: AM5PR10MB1746:EE_
x-microsoft-antispam-prvs: <AM5PR10MB1746CA59301A00047149C6EDE0D49@AM5PR10MB1746.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yotImCHIDHoMCRob2cGwzAqaJ6po8HQiH0tjHpFEMEX5KtNCVJnaEDThwiaOpq9yWZFPyiTkeW9LR2RTs2wWUBTx+RY5A3QxBftx+bniCAj9gk5HUzM8aVw3wBSPPoI5iArAcXnTqW4fWKkJydwinhSEsJ3M4UdYRsOI6zCR4LyKaztNt5mc3n6EDzfneXAqlOlw52d5OmV6Gh58qkvjuWRl0wMyicGlEvAtmA/HweahXf4uoE01yXfkVqBfOmcuNQa09jC6TAKhRp2g39DPp4ulkhbGQyWIX2jB1ExYBBvuasg9y29nTVKckq+8mFlLGPANYwUwij9+4SRHcT7/AiHHjEJ4v0x4oNMEvL8rWU1JJ+cJ7KOBssWKi2haqCGG63SmsbkYX/w5YMPFdTR3VOBTooK4FFS7oi7DH59b/OrYD7Zq3kX2FqzX38P+W6GPIJxCfi06JrmDNOgfkH5CQutaG/MI2mLUqsGOn2glblxpvvcLLvU50ZhlQ4q8ta4eWdiBlV4ThFBDWywuKB+yribi6EmFyUw7ngR2fLGryRLwifc9bLk81pVrcgCt/X+UcvW91YiV4yj9kWYb0XFDiBGpsrkJM4e74ZrMq3/ksNzbsahN3NLXpyohMvunenHFCVgE+Seb8II3NS5caV9vNQVaKSdojfqzJx3bG8+F4pyleZjXdvQNdS/Mi4jvNlDCHkwfAtw5z/CQlM6ZiN8+pA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(4744005)(316002)(55016003)(122000001)(8936002)(82960400001)(7696005)(52536014)(508600001)(8676002)(33656002)(4326008)(83380400001)(55236004)(64756008)(86362001)(186003)(66556008)(54906003)(71200400001)(38070700005)(38100700002)(26005)(6916009)(66946007)(66476007)(6506007)(76116006)(9686003)(2906002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oX5XAkeA83qAmhYaatNAXCNW2DUMvv5dpai3pj3hzSLRpObzbdOWoHOnT60q?=
 =?us-ascii?Q?E+u9WvykZU5vFvb0+WtLt3p4fF5Fdknk1DKHj2RE2IntQVlo3QjrSzUD9ysz?=
 =?us-ascii?Q?cfZr4HZowe0WllZKsRk0J2njf9mpepnLXrr+Q4baUT1MaFc31iX9iyS9th5r?=
 =?us-ascii?Q?5bhYa+fioTPGRJ9gHhEG086/9gGO3dkfj/KAPOnHr2lSVFQrwZDQn/ZZMv2z?=
 =?us-ascii?Q?pvkG7vqdlUummOLSDljYjGKA0m49rn2NdJWVaBAcbJw/z7CVzsKibwwoAbgy?=
 =?us-ascii?Q?2C99Y8rYk8gQATplpXU+Oq04PZcVvItXNFtfvkny4VAE6HupYyOMQYdbu6AF?=
 =?us-ascii?Q?y2eceEmw8oIGp05JY7Nm9EY2uzDAVYtZ/YQoaFxJiefkMx4vRJMlPjcDIFAm?=
 =?us-ascii?Q?lVceszlfASz8yR1rAMKuxOivoGjafJfJLpUE6PWmrr8mhQ/g1dnKiwvARjnh?=
 =?us-ascii?Q?NBkuiYdfYmBVXRAvX1p2v13vkLUaIXn4ZRO0GQbFZxqAldi/tsph/WZlMOqQ?=
 =?us-ascii?Q?cy7qPW8eNmpKvXb+GjmETFP1qrhdrL9ZRfgVQPaK/t1jp6RvMidIOwODjxA2?=
 =?us-ascii?Q?Wfe60gV23QZHMFrzfoPKp++ZsjWLvJy6/NUzCG8CFJnZZlSUyg2BxbvuZ8kl?=
 =?us-ascii?Q?jGaAouyKdktToOJtJf8VV32nL4vRqjE4tzdhGo3Q6GhQorVpArHz9dcXtZnm?=
 =?us-ascii?Q?Y+KKH3OwT2DXVv3kfxxFsBrwuWejB0YMRJwn0YkHEeDYZXiNgaiO7I31WzqX?=
 =?us-ascii?Q?u1lYouBO7ga7Yj6XJS6/RGUHexDbFsHEDLPCYsEzoqaJRktWGcOuzXqH9ac5?=
 =?us-ascii?Q?P/zVrSGMtghv5ufzWiZF+DOPoitfzMdpuL/jBFuOJerahxT8jGpsHUlKAZaI?=
 =?us-ascii?Q?j+kAkmmSEZBeQGijg4PWHwFUrVJu7t5VaSZOVMyYNuQTlJIPyjRPwWPUu3ns?=
 =?us-ascii?Q?T7U96D6mNVjD4H30ENhm5aOVDTkV5J+VTr5nqXKKUsQL6vstsBwOBVWCXT0r?=
 =?us-ascii?Q?sxn+dd6aV0E0P7TJOLKeK75SCN+5GEQg3PWfIyoa7gz/xR9g4GX4/OVM9JfM?=
 =?us-ascii?Q?3xN4zGihp5I4M7iZMw0AGyfmc7nE0aRk+fIwEKJ+HhR0UxQP2Fad+b8Njls6?=
 =?us-ascii?Q?huq23r2u3eJ2p4M7aMMbkAJLMLjvWvwjlo7vcKqx6+7VhcMmXRsqfQXf81Pp?=
 =?us-ascii?Q?fwm2bpPvJAnAoOkd1Apmjos3YR3AbK24RintXBNzrLs6DJSD6Hed6rH5LMC2?=
 =?us-ascii?Q?AuUA4hz8D8/864gdbNszNu7Vhsvmh3LmKcaJGT07W2leuIWTJH6QXjq0ZCKj?=
 =?us-ascii?Q?aqOXPmHKAP5kPR3cCb/Mw9xQDpjJiwmCw40yMbFFc2szTg4Je6js6S/VyT7j?=
 =?us-ascii?Q?OwTcdaY46LH1Ltb0VBzhLqPYLnYSCyVTHGU6S3lFFCxgbv1+28LrB72iMWFA?=
 =?us-ascii?Q?dD6dZLC8aGJ1U0fOTlNzpJY9V5N+2iGz0K/UMGk9EPuUkzt6YhBYz19wCHjZ?=
 =?us-ascii?Q?u53oaL168y00hc8xyBXHcMo6PAFUkXjcESVfFb8l5LFMo5OXOmnP/bWE1XyY?=
 =?us-ascii?Q?wFwakV0ZYocVIIr8R6B5NqijMy7cTiB1OI/dzfYXPw5tn4xq46+TjkZp5cOV?=
 =?us-ascii?Q?1MM3BxTJwSLOBeD6f8YWAGExXsX3AWIyTkK6DYAPD6kQtD9HKKSunNtqqhkO?=
 =?us-ascii?Q?6CGujt/xJPQIOUU6uDttf1/RLzhLlk+sdKnCzGGOqXFOQT+bC6+1Ku5FTeI+?=
 =?us-ascii?Q?W6+0vLuTcD90b+3OBdLR0VTlvV63kmY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 67236463-9e6d-475b-eed5-08da3c988948
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 08:45:06.1987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Xtje3hVuYFMGHOjv1YjROQr+vYp9sph8Sg9WyKHQHMDp8ClJk7sDEAv1S+9Lhm5rkL8vpoBT7CiKLj0PVDiZa+xMjVtLaWaWN6wUGWo2pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1746
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/**
> > + *	gsm_dlci_wait_open	-	wait for channel open procedure
> > + *	@dlci: DLCI to open
> > + *
> > + *	Wait for a DLCI opening from the other side. Asynchronously wait un=
til
> > + *	we get a SABM and set off timers and the responses.
> > + */
> > +static void gsm_dlci_wait_open(struct gsm_dlci *dlci) {
> > +	switch (dlci->state) {
> > +	case DLCI_CLOSED:
> > +	case DLCI_CLOSING:
> > +		dlci->state =3D DLCI_OPENING;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
>=20
> The documentation for this function is odd, you are not waiting for
> anything.  You are just changing the state.  This makes no sense as-is,
> sorry.

Thank you for your comment. I have prepared a new version. I will send it
after the other 8 patches have been commented.

Best regards,
Daniel Starke
