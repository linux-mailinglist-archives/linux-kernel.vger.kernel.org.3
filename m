Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508594EAB17
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiC2KSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiC2KSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:18:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9096B23DEA9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZX39efLATe3CYsMLkaKJyJl9qlkt9+AhZpgRijMofTKjz6ZVCGGvdMiEEw6X2LMRNTmUiDCXmMBVh+7zPfGgi1GnXs/2kRABY3LgrVOZqhVrBsjEE4oJdi+KYUEcBDV8m0uVaUO3dwgn4OGDP3IQnpDjEW+CJ8l/BybyhZVnbKTzGJPXDCk0MtSc/H795L3ux1j9kOGflSdDvt7aZRbdgGGnQoF7dGvc45jzQ9St4YAb7deSOk40Aju034wWckzhIhFiWyow7ODR9jL7DU+OP/i9GzshQQFxPPlW+s93DoWKtleAntlXHtsr4/hT3ICZ3vNTNxjuqib1vlf0w9a9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDCjO0F8jlQ67pMFDIjxjOOSSN8ODOpvFB/69ocZT+k=;
 b=hDe+9PAZMHRZTisHby9WglQa/N+eeV23egNqE4Wh1FmCpEA6iibLGT/hYBbhbmYnXYnuCewz1Wrw1+ibe+F7raL7PRJw/21/MNj2mhGRKxr1FkWDL+n6Lllc++TewlbF2qd/M5ODnvWRFdZIYaPxWNH3ERl9ysDQy+Tomx8qqdji0zgSvNh0FswtUQtbM/MOvlJ0n50F7KL3ECSQRezdujvjqTZ0OO4xwNj2Qdn0TP860TwCwX3cLJzzsilqU0paKkymoW/9l+sSaBlV1pVlw30FiKtBUWamqAYsVMeMw+qutYQGVP9RycLGlPNNZvoxu1peOJC6LfdySiBD8af0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDCjO0F8jlQ67pMFDIjxjOOSSN8ODOpvFB/69ocZT+k=;
 b=j4nRRYxK9qRFhE50hxqDgqRgEj+f+sU40/ArQl41B2IxYgShA75UIU8YFDCSDj8VNKbbEO4J70F1rga7yH+qBApx2twGpEWwEsJSgGF8oxOAtsJ6trTp2NOI7lEte3G28Sgk8xrHe5jqIXfsKhZvn1aDXWWtVbwLlEKQarjlN+M=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN7PR12MB2707.namprd12.prod.outlook.com (2603:10b6:408:2f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 10:17:00 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 10:17:00 +0000
From:   "Zhang, Hawking" <Hawking.Zhang@amd.com>
To:     kernel test robot <lkp@intel.com>,
        "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Recall: [PATCH] drm/amdgpu/vcn: fix semicolon.cocci warnings
Thread-Topic: [PATCH] drm/amdgpu/vcn: fix semicolon.cocci warnings
Thread-Index: AQHYQ1YgGmY97m3wH0iRqEbTLi2umw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 29 Mar 2022 10:17:00 +0000
Message-ID: <BN9PR12MB52574FD57DD34E37A72555D8FC1E9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43893804-0da3-4694-56c8-08da116d4338
x-ms-traffictypediagnostic: BN7PR12MB2707:EE_
x-microsoft-antispam-prvs: <BN7PR12MB2707863E1D5DCEF5C41A21EFFC1E9@BN7PR12MB2707.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XT697D0ED9U1emglPz+C+/qeS7NI0XMeAjXxmBZ2vfemH2I7mYdiSpU+4BP9rRwGMZawdueK+5S9/yp1NqMsKDdt54McKcaEfpUg+b6juq+/bMehVJFl9rp52KLuY4sNX3TGlMBwxFD5BVrbEAbD3csIoD6xmRDfgWt1ZbAOgjP2wPyGRqtyeNT9df8XaQZyQZgfvte4nQQGj5ckRhs/MrQuWmMRxC8CBDt+mJXM8KzTDolm4EheQWUkkOqBy3yUak2fMv9axx/g+B1LnF9HCg3P0MSeshqloUwN+nsjtHVlGmwI4djcNuVnn3ei9GkyWhiUOp9s6oXCuRZzZ2Nr5aEaw2vXsWqn5OUlTM8KduTXsHfUWDSkj/HnBCPlijRUF0EoKx5FN9IKWHyfSKOj+y2OWImpi3MdDKhNZ77g0EWV4JCOewQgPai3uT11hM5jWsZwVTwnrK87Jmi1seqTUFMdVaJDBvjYH6tUIUc64+aA68Rrr9T3n4dYkXDkbMKks5GSjhw7HOeSuP0CYyEMmTQweFvOCvxWf1kc2pOdg49q7i/I7SV3163NwRDFag59C7bKenHpoLVz3ZyKb8c9QUSvBi89iz3AhfvXAlkyqr4a+0GnCSjWsnIX8BQSOOvcX/T8dN8nUCUZ6gii99fWvrW8aL7c3xWHFzOKCj1ULj3Z+wvt55dkjuDLSwLYcRfP5JkfVAJzSN804XMiYiPthQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5257.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(508600001)(7696005)(52536014)(4326008)(66476007)(8936002)(66446008)(316002)(66946007)(5660300002)(558084003)(64756008)(9686003)(38070700005)(86362001)(122000001)(6636002)(76116006)(55016003)(66556008)(8676002)(71200400001)(33656002)(54906003)(83380400001)(38100700002)(2906002)(186003)(110136005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p9YT8kLGp+JImax+kG/yy6CZmSqbxTrb3AKFxsAXXvNLYMwIRx/feH+J0QOh?=
 =?us-ascii?Q?+ixapPbWpTL3Mego+Wy56aXMc1VK2emxYW9BYvI8eqPqru2meTwz7xvYcJ+N?=
 =?us-ascii?Q?S2oWYkTp2j4fMlI86ix4L01Z8BSBWgn+iCfYKn0om5k7iwpQqfZfVm41dSNH?=
 =?us-ascii?Q?vHZIqeUNA+lh8FdojnJLmY5Far02i+nEUhGPqflYwtXdG1hzAMIn5gWmgUtW?=
 =?us-ascii?Q?yTQQJHyKQSsBptbzH0JPg/VTLjZ8j0DwS+mbfhshB0GE29IQny+SVhDCK238?=
 =?us-ascii?Q?ubRSNszP+CbIB4BW2n2pfRYzP/0c/GTcJHJzXP0mFGb8kB81QFsc6jDJQBjh?=
 =?us-ascii?Q?egDR84C0zkd7EIyrcUdqr/MKBLcen9Sv94bPYMZUFR6AJ5JEfLgp4Zwhx9Zy?=
 =?us-ascii?Q?EqmimFetKd4JOi7DXgi2gNKZXuvis65fD5eYNa1t/yl9wgb9Zp2iu8FtelL0?=
 =?us-ascii?Q?ju6Vanm58gNtTLFjFFmdXqg+2lrSiWArwGs09kPAAkYEJAk5/19c4wlfS8oK?=
 =?us-ascii?Q?xjRlKvcVnq0j+prxTCVCzzfcwuKURoJf422h/njoIlG4ir9EzZP+5PP++kQi?=
 =?us-ascii?Q?REwYdR840qB3RwRhijs2PgDdfTEoa2Uu6TLiWYG+2EuZurS9A8QZz9FGLACW?=
 =?us-ascii?Q?aZ5p14HZMZV2zfxRRhv1WJr3nd/fiavnaHJaGIMo4D+1T2B+xn1MPYNsdPNp?=
 =?us-ascii?Q?l2LfniqjiOPqPxFs9/R3niD5xZQMGaIze3aYI1wiF3eIJ/azSX2zl1er2lVl?=
 =?us-ascii?Q?YQde0cYCzNSXkNb8zJ6lF3B9+lfnVB/VedWjAMU/gTMdNdEou/4jyusz6CmJ?=
 =?us-ascii?Q?cDShsNrJnK8S4xf907u7NcGuJ15fSy8R90fzK5pZDobCsslrskSXKIJaV1K2?=
 =?us-ascii?Q?GW67yQE6EJEzU64CY/KpA1R1K/16rglncoM4/Z2wYRiM9K4W+eN93grw9wIC?=
 =?us-ascii?Q?h46wG2kPxscHzJQeP25bxU3AWOxQrXGJKxjGecnQCWCNVHidQizKlM3TfpmR?=
 =?us-ascii?Q?jmqo1ANFiauRoHPtLp5hkppNW7vdVQ3k52qfnUGwETekkBgNlEwaq7K3y8UI?=
 =?us-ascii?Q?7Jw9SlgHThzmu+8ZyBbN9tLVfjXpW4GuZkT074ZGFdX+mu4owNyTf1L49FQN?=
 =?us-ascii?Q?N3UKB8BKK0w8a3Te91tvJLI485/Y5gDP0sawGwmSQQl/PVIYwYOaHksXqFXi?=
 =?us-ascii?Q?0lhkczPubwqHrvIrUzB2T9561rk6E7A75hJsa2QEbN9b6A4gBeBFPcyg6bU1?=
 =?us-ascii?Q?mmG+OJsZ3W8Sp3Pnp+M31dfono/6xcq15SUEUhOc4WfUjkjG6UPyVNZO7n18?=
 =?us-ascii?Q?SKjXODSdWbxngHXLBPVl7klh5AViLBqKcm+WtaedOiCMR/nYN+SUAr4pFOhk?=
 =?us-ascii?Q?v7W1Ok4b+XHCBDb6ZctYs+GoOK/bGgy1nC9IxqUnIUciK8GrvFZVJI7//vBa?=
 =?us-ascii?Q?L7TyBj3/QDbDdFKmb7Ylsi46jwkU44V/eprPnZ4Ra7CvlY317bKpp1wFjg7b?=
 =?us-ascii?Q?UJZ2QLFlBJ2Lndj9BnJZ8aLFyoQ/krWlKAzqfeh2kbsKIeBofp1Pntijo01J?=
 =?us-ascii?Q?yNsMH0j94xyvE2HEWVn2CooCMWp/2WUVB2OAXQEuhgrJE7byDGReJM2PB6T5?=
 =?us-ascii?Q?1aSkx1coXmrZQhsorqn551wcKCA+2ChcADrgobO+mGFS7g70FzPZu3vxDOm5?=
 =?us-ascii?Q?QFfWy6ulH4rE7u8Zgr6mWc0g68k3/lpoqXH8n8VFqZ33nVtHNlv/fdlKVvWt?=
 =?us-ascii?Q?oJgZUmjU5g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43893804-0da3-4694-56c8-08da116d4338
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 10:17:00.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ej8zdwuyLUILovGEir1O74uMESVt8ZvyWydU4/FMjjRPuy9DwjcPq/BJfvFfBhuCMk5xA6F3IFvlzq5o5lRxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2707
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang, Hawking would like to recall the message, "[PATCH] drm/amdgpu/vcn: f=
ix semicolon.cocci warnings".=
