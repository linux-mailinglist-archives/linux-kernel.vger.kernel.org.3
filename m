Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D95A117B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbiHYNF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242217AbiHYNFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:05:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2DCB6026
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m49+wyS5GJCYmrwFURZvyglOMUcEa/dfUKsrtlaDTU1dARkHdTqgnCEfWpqySquRHX21M0mlYPUXKXLIbM+6oX5MCdHQifAoa7XoKGsBo0+ZjgR7fYI51/RjuNccLyDTKmvP1f5dLXCQjITgNwNpjiRB8/a2tNsAoACnAJKS3XQL8VW6ocOlOvFqbrpbVDn+a3G18ESmlQxsgCLqsXIfAA5VfU9CIAbwIFeTSVjNUXD2yA7LuCr0KT5QKWpCVqnn/8T8UHOipyP9DZzBkDLlElYp+FiFUqDjMXMDhTFaNjoR6vyuzcIRKqzS2Q68cDCpVbuHr8yXCP+z4qJecQf8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g+hoqm1RPT52PU0Ve1Zj+dnGwt6UXgln0ipqdbNJ44=;
 b=aP0r6cW0O8u53nw3NZNWo95mMpFtnNwVf/XCOSWzWWI5g/kYrEkLvBmyfp5Yc3UxmTG2QVw40Wyr1UW6sutXoxjVtn/oLk4ihBiY2cPGI/K6SED08SAU7+IuUdzV34xzLnwgLAHFoMQOkICAx0p7whgdlka3DANB1d+CkVwLesbOilxlUn6fURA/gDWnVj/PvU1rzEgLZFOUK19ph1wQeaJF4ToKEYGy5ud9J8FGryAjf06bjmmzSIWFv9wKC7kj5AKYzoh4V2udX7rlWn0XPnD8zUuJ2+j2nndu+6Mi1+EpD3eaOwMI+BdC+axktYWc/w6hA92jCQhM+fmcv3mR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g+hoqm1RPT52PU0Ve1Zj+dnGwt6UXgln0ipqdbNJ44=;
 b=MeeSfWSsx4MWMSmiIM40XTKCuYSu6E44kbyxeFEF520rmNR6nwKCmuEdXW7N67bzH4w1desvs6lwY6V4ke5Yj/a1CuPh8y4zSw0QUKCD7I0zRgUljKgDe2UuTeovmjptzFuEHZ3OroNAP1//uNaJKsURklt9SLzyWpwo0cF4N4HPFT4EhwbEhR/zsl4plrqfhCXk78N3dH2c1/+Dq9pKVbDoiQfRTjpQfTLYHj0DKybCLh8Mjc9an2oOdRYYRG/t0d4GPU5Jp8/VRpZjHSkfGqNk96AA/GQpZbdH5GeL53yWDe7LCu5D8cfrvSumKeo9AdKH9haGzoH0JN7jc4x8ew==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by DB7PR02MB4554.eurprd02.prod.outlook.com (2603:10a6:10:6d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 13:04:20 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 13:04:20 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Topic: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo62/j2GAgAAF4d8=
Date:   Thu, 25 Aug 2022 13:04:20 +0000
Message-ID: <PAXPR02MB731064E010309A6A1E340CB681729@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <20220825124123.GE2030@kadam>
In-Reply-To: <20220825124123.GE2030@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43ea6de6-9067-46c5-9cd8-08da869a532b
x-ms-traffictypediagnostic: DB7PR02MB4554:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: es6ucGM5Q0pDJRiohgN0BLXHSfP3LxYszxop2gfNVDPLm3CAej5/2UFfSkZBFO+NGxrUfiOXPX5LpFjzRvpmsbS8+X9/6JZ6W0o0lBRht80l/Fe+Xj55vtauRr85IKCHRbYXhZb8HmKe8EXXUWc9hrP9b7k4jldW3jtAUSZ1+dwhROjOAEudeRrQU3Atg4bGr3vcNhLGd0CD4e+rYFBFVCaKxspgrfhN9kmM5hsNFb33FYwRH3YLODTbgzfh+FueJ+u74blxwszNx1ZHKBowM2WMxv1EJTzEq4nnTxpTnoOu5IZqUqnJ2WhkOjMoRYT3HtMR2ryeZatqfaRT1zFBOvqsBIx7NlxuAP8Fjvqep4yAQrNEzrlzIwzXnji26nCUnUApoobT3iclP6wfDTMoUrgVWyQpHOykUo4pXifOiQOEcK5oXU5TWfWiiDorTsNIs5/tLAy/UFf8IsxWXp1xl48aYpu9etF36XNUSEViD70blj8kbtTUovFzx56GwHjx2Zs4j1JZkcgUcYcf4ApDRLgUC/WXtgxhJ0qSoblwaay6UP/oYpszkGN4bzF7CzM1MR699RfMm49ImcmkhWWEgYC/Z877hLZEHRglXV2otNdgQ4wv6WnX+6C9NxmgYZj7I0sZgNzypn7VWNKte81Puf9g4QLljS/bDsaLuAmuX6Kxj5yMqqAz1MKNfxMeR5w/TIO0G28L16vV8m8qGGTtrw/RvyayGj2n+I25M5PujjktIRLS3wsJYZoOpLS8ZWMqKEo3X9uOwUUmWYiCdKZxgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(4744005)(41300700001)(6506007)(478600001)(71200400001)(7696005)(26005)(83380400001)(186003)(2906002)(64756008)(9686003)(8936002)(52536014)(55016003)(316002)(7416002)(6916009)(54906003)(4326008)(8676002)(66476007)(38100700002)(76116006)(91956017)(5660300002)(66556008)(66946007)(122000001)(33656002)(82960400001)(38070700005)(66446008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wXlzCq05irkGmFsRJyCb95MjhrX6fzpPxVF1OsZWs8ZoJ5vUuC7FuHs2Uy?=
 =?iso-8859-1?Q?gXmy0B+QUUG7YA99STm56bwzaXsFEG/jXmK3sCTCSd+7qUunAnQg7VHRCy?=
 =?iso-8859-1?Q?icKxBipsKixFky7IIkTdZBq8ZP3l8qtQc06ttRDgEaB5Io8vKYfbFSEtbX?=
 =?iso-8859-1?Q?DMPCigvAK8eaYz97IPWjETRfDC2UpFrywVX2ABJNbpz0h0MCLJVw/dMYH6?=
 =?iso-8859-1?Q?jd1WC522crHlSNoNBl288TW3+mMIIWs6MU1yywGEkyo7BikEgqcQn6pDEG?=
 =?iso-8859-1?Q?qXNEiGEKu9qDNmd12eoSVMMs9laLfw8EH7jwFKJM8Ra/+3m8FGJIJW0zp+?=
 =?iso-8859-1?Q?+N0dRKawgNfIS0EBUp8HnvTr/XGKo/DMNHtiOxETNhSx7xw/4aoBLPaIGF?=
 =?iso-8859-1?Q?5DUlYfji95myyX2+7Vz2e7Uv8ajnFn1vBXA7SdrZGuPDpRCXOEqOhXp6N9?=
 =?iso-8859-1?Q?+TB0yzeaqx2Q2NcGGMLeMZ1OkAERuDdVyLaZOQO9xHHzXQhcUWx5liEPVh?=
 =?iso-8859-1?Q?6I7oJGT9G/1Dm1wK0/5GSUVwrePsNFy/ZiD1LuvFbu0YBWusDoKtikEV09?=
 =?iso-8859-1?Q?xRIbz7dhxSh9el2avYnwNcjk3/8D64XAGd6Y2wmoOZihJw8W1/dbtqDblR?=
 =?iso-8859-1?Q?sMnzdwB+BSodAHauHIxhJMJWupbDyAnP0QBU7JuSAwkb0qro4Ct1yUtBjs?=
 =?iso-8859-1?Q?6vFJecNj8ESNaZy3ZJxiBe23ohWWmHecpP0VHTxczQBHyVo59jej33zeR6?=
 =?iso-8859-1?Q?imNoxmoBCyW+k7bnslIdcg0Z0zD3ZgwoaST2jAJ825stXW7xklyul+7bjC?=
 =?iso-8859-1?Q?zB/WnTqWvIxTT+9FnEQJOaPOxdQi5CTeHcPBAaKWb5NNgXhP3fGWa4SWRx?=
 =?iso-8859-1?Q?MvOUAfDwyozXs8IInkbe7rfi99hIVh2WuCRFRVINZs407Pf4Eab8FWSHFb?=
 =?iso-8859-1?Q?zuKRjYykHjEF5D7tP9z+AiA3B/9Mh90QcN72XcQnV8SsC6UgC7AaRPcNfY?=
 =?iso-8859-1?Q?Y7gfS5MHgZULT36M3pk6vXBdCrJcTXaIQGTfGu1YHBbi1HmJsiPHX138Tk?=
 =?iso-8859-1?Q?D6Pf5d5FcQI+rXQEBCJ2voGVg6Pu8smOK2hWZpOwBZbpIl7/ThkrMNvULe?=
 =?iso-8859-1?Q?9KNAu+0ULyVfYQIwSBgCnA35y68SdN29vTHHKU6Isbh2SXtBO/2fldaWPi?=
 =?iso-8859-1?Q?8xcwdOgqjGlmhn1Dr5uKK9xNZRoiX0X0TPzwJU31ygXN5YBBVFudlanL/3?=
 =?iso-8859-1?Q?CcjE4dWhaZV+BtK0VbaO4g0kDrEIFK+v22d5YG8lspwo/Mxtj/e7w3IWx4?=
 =?iso-8859-1?Q?CUu9ImIZyki7HS6DtKCFAGRp9Lx65DA19RJ3UjLY1zADS9MBw4+TFXHzQb?=
 =?iso-8859-1?Q?FEvMn0mG5rbw62v+tBMNwTPx4DIVLhtpT6CQFZzXW/CUhmjz6g205NE3ah?=
 =?iso-8859-1?Q?5TN9LAjs6HWpiVGNUIGugR9DAq8Wi7podmklsfduHZxlOW6VIraTzlpSq5?=
 =?iso-8859-1?Q?JyeYOlt3BgpwnEC4AuLJalY+In9MM25njq/TqHhHMRKoQiq8Bz+mKo10YZ?=
 =?iso-8859-1?Q?/tkoAJO9jNnVDXk5tmfIXo84qY+0R3vVQDQobYdPAbzNfmgKwZE4+TyIJJ?=
 =?iso-8859-1?Q?9WmUlkHKdKISQe29MaHpB4YUS+x7aM/KzF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ea6de6-9067-46c5-9cd8-08da869a532b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 13:04:20.4642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F38XZJMmELNAKDA42sFtbQnzK/EWWGjStvACzyShyH2N9soFqm9xUWmY8uldU6TjiNLo/ymgJfSbEz/NbPxZMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4554
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Dan,=0A=
=0A=
thanks for the comments below=0A=
>On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:=0A=
>> +obj-$(CONFIG_VSMP) =3D vsmp.o=0A=
>> +vsmp-y :=3D vsmp_main.o api/api.o version/version.o=0A=
>> diff --git a/drivers/virt/vsmp/api/api.c b/drivers/virt/vsmp/api/api.c=
=0A=
>> new file mode 100644=0A=
>> index 000000000000..6e40935907bc=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/virt/vsmp/api/api.c=0A=
[...]=0A=
=0A=
I'll take into account all of the rejects and will fix them=0A=
in the next iteration.=0A=
=0A=
thanks,=0A=
=0A=
Eial=0A=
=0A=
