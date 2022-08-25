Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC715A1133
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbiHYMzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242029AbiHYMzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:55:08 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1F1F60F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDJS34RKREIE0RNylfD319qPwbuQmeu4aAq9tq+TjnSI0kOZGYj0pmbw3qlJ8WbD/qSp0QhwvavOenRYgxUsvGvTY+OMREyFIBbcPN73YJ87YadNeELfEqzQmGisy6uCYb/W5HR0zlcrpbCwhhoUnwNpuEHv5eJM+rH5TOdm1j1r9+rVE23Oa6QbbjXkzO2uA/6iADtHcd0dT7gWVx4NvbPCUouP5xoWPLR6plL1x+yQGW//vY5a5YW8AByx8ap0PKJ0yZaG9jA/HywtsUBOaNkDF6UNlRhRhpglgrSJ/+F17w6PjzqoOnHaB5GgvTY78WFAZEuuh72z3qgl+g4QBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGZxK2kJ03N8pfSsNcsFy8SaSri/IXteJFtjRoDFtI4=;
 b=J+AXoMLLiIV+2LARWibJUMxgugUEs7Zs72tV45WMtywZNOc+Q8yszRXindY0rHTxA3pvdlFfcBPWCNa0TZEGEWVGH1jMoI2OLMj9JcaXp+muvACurQfR3MAcwMOv3h8aKYE+9ujWh//wyGzMPwbtFWVLBtgOMXg9crYtt5ALuJnpPjagjzGtJsRysGhwcuvFBMY/rpGcLSdsDrTHZQMUZcM3z4brFAIkYyhe3F+eN56OnTsWyEXZVT0wjJFD1GPsjTdfWMDWoHuhvGnWg/a9+fjmLrhru71afBboVO1fV3d/sHOQW5ekrh8JLHepYlCPHYTu1zJ5tJ4GV4XYFwfEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGZxK2kJ03N8pfSsNcsFy8SaSri/IXteJFtjRoDFtI4=;
 b=b7QNQ9W7Ugk+LzhglgV7BgGLqeOH0lRhp47Er81dKkra0FXAF2ghdAoaZvyoLT1j6y2xTsKz2JpLWfU7oMgTnjdvf2tJQ96PuPk/RgGUIzgqqix2KuhKFkzWsdJ4tj8OWxoFtKbYhWbhqXBm9wI6p9RZKdP7UWsELWqEsfMMsCgD1Fgf5Ts61qZVxIlneXP0485D3OMw1JPkUdYVQgTyTRGXL//NCqPOV5gILQchKOsyJXAB1v0Gcx3XjpnW9ME4PVY+JTsGCYX2urfTPp6pRxlLFDTr78o01NW16X+n5JgLpJ6Rm0WtpShwXeA6nhKqrEB/lvPnpjJ7XzzugzeRFQ==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by AS8PR02MB7463.eurprd02.prod.outlook.com (2603:10a6:20b:3fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 12:55:04 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 12:55:04 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Topic: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo62/OPAAgAACsWWAAB5kAIAADNqvgAACQwCAAAE9j4AAFa6AgAAESN6AAATmgIAAA1dFgAADMgCAAACCvA==
Date:   Thu, 25 Aug 2022 12:55:04 +0000
Message-ID: <PAXPR02MB73100D7A8AA0E12614FDB10A81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <YwclcEJDf/POuHw5@kroah.com>
 <PAXPR02MB7310DFE86CAB92D0AE1A14BE81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdBMIgSzEiFjc4D@kroah.com>
 <PAXPR02MB7310694F20F95CA446FFF22481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdN3vJ1Z+1yKfma@kroah.com>
 <PAXPR02MB73108383655C1FB4B98C3C2281729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdhF6r0egBc3w1m@kroah.com>
 <PAXPR02MB73109BEB7197DAEEAFE929F781729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdoyzTriZNr/qN1@kroah.com>
 <PAXPR02MB7310B9D894613F9623D6D5A781729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwduRt8moHJVKwm5@kroah.com>
In-Reply-To: <YwduRt8moHJVKwm5@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 135c7d47-daa3-4de3-bb3b-08da869907ec
x-ms-traffictypediagnostic: AS8PR02MB7463:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8EvEWhE/3sK/EDgBznxLXr0aid6H7ghzFkooZJ8auNT/ZEh2yEJSgOh5DPgRa9p4VZt0ayhpfpf6/TvX1IGMEVa/aI5rwRKubTevVs7Gqd87kmGtbIJ72MeGVXorWmkSvwE6Nhmd1otSthez5gBX2e1JUxltc2RS0GwSFkb5F8Ex7d849STd+/XJ/D96pTJWRPaZ1T/Q06Zf9VaZ00oGUKuycWHxAYhCW2OJarZu1MUgQhqhUx/HFx3t7NftOsoBOLdsylcnT8fvP3btydiRksiWNcEOJAxhgK9c15c+QTPr0alHoRlWyP3wD/XRGmLuOd4tV4QeyNLiaJJOPz/z2jq+f3dUE/MZ4mEx42GesYBws/mUYw5HdY/a+sQAvEfshbBizUQMHdjN4NLHaOfRMYbG4CxWodaS25arJinM4y/yFJRmqd5w/F551EkhrclxJN+SxBPQSEcrXt1zjw5krSEWgD+2BB6FzC4n+HT6+6f/acnJl52ZBYdB1wISd92v50+wAxF+ItSvnnOApBITi4AbwR5oHnvaQt/beolQe8Jxy+zfustjRY61kt1LKGBs+r0/4nsiQcCJJmpV6zc9i7pC8i3trBrKLO9LQp92ZfKc9L+8LMt6dRq5tOo6v/2QjWxmzoIz+ZNDQa1xav0LHn8aS/PR5aJ94DubrO7g2SORsm6SE88nPKLvoey5plLTidSOhqfZmxzZZ03j3zVwGS9SwcxjMT+PlfZc38FXMoVo650EAXSdBWnom4IRsuL2t1a+bb9mjtCKBxp0BwJjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(86362001)(4326008)(83380400001)(8676002)(66946007)(76116006)(64756008)(66556008)(66446008)(8936002)(7416002)(52536014)(33656002)(5660300002)(41300700001)(478600001)(91956017)(186003)(38070700005)(6506007)(7696005)(26005)(66476007)(2906002)(38100700002)(55016003)(54906003)(6916009)(122000001)(9686003)(82960400001)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vlnuMcvYGTrbWALZlGPf8gbahCja/CPlJ271tpVCu4K629Xc8AZSSpLi4i?=
 =?iso-8859-1?Q?1IGbXiKioAQnyZLeixbV22YHLs3DxsTRT6l53iaRqxizBbIfNn7iAZOUgz?=
 =?iso-8859-1?Q?59FDrlHDUZAekxW85QOIb9Ao+wR7LgNhCHxew7w5Bl8I2Yb25+EUqONR6F?=
 =?iso-8859-1?Q?Ntm2768FgfvQm74gIJsbnO5yUVSq6HXg1wbI36zlDjKazVjL033KUrLKCg?=
 =?iso-8859-1?Q?B6jTsuu2whZMItO877qYEK7vk+RIuV+YgivQAIDzrMb5Uh4KhC9LKisSsf?=
 =?iso-8859-1?Q?A80IHfbEIaoqYJRNYvmUNUR156qXzTuiTVdLGcXK5PPzwPV/soI/Xe1/i5?=
 =?iso-8859-1?Q?W2MC21+TyG0d3+TMd+MsvUU3fDEI8B3nwMsR9Quiqr9ReFWEtXIzatNyH3?=
 =?iso-8859-1?Q?JRdY1g1AUsh2xSDnBZxJD6eFPVTQ71I9sgNsoqFmIaf1nNHQW85//AZFKR?=
 =?iso-8859-1?Q?1JDVVPF6PqKO2SSPSe54WRzJAROHNsXSJE+Ufh8s2YVRrO1wIfMnUhXoSm?=
 =?iso-8859-1?Q?u+jcRd7GfjgGLlGRgO4AMTeESozdCtu+huEEZ4WfVyABrsZ7ujyiY79e7c?=
 =?iso-8859-1?Q?d5vQpUQ59gHLTFDRLIvTO00j7kVlHX6kTudlw2WHk/4p3qrXc+v11a7ZaP?=
 =?iso-8859-1?Q?RKMECK97a20XYXRoqJAQPwMiYgN8EQG8Dzhgf50Cff75h37GDoxV6QjBUZ?=
 =?iso-8859-1?Q?naD8JYjyEWNrXFoMROFQZlTm7YALYQTVWjEshlEVgcs9h7zAwgt/mxvL6j?=
 =?iso-8859-1?Q?6fbQ/13/FTYzsGwU+GoaYVK9bKEgFKokjfFPLCidykCIzX9uUjLPYMm/07?=
 =?iso-8859-1?Q?LRtt8M0HdUowoWmqv+NFrAHKYrH5R+sWm7IlVfjPDFo88Z46qeCq4j7Bv7?=
 =?iso-8859-1?Q?JiKQ3Y/J3SUDvWXYtOSWSyzpHHY8qNvWSQbBpL+J55JYWz6fke4PcSZ/wv?=
 =?iso-8859-1?Q?aEmR08LLGGWKttHlemuAeWOqTcrO8R/eh+x3kzYzyB5WpO8MbLMeAzj0Yo?=
 =?iso-8859-1?Q?F/Y6ETp6+dTjI9dM4oVm/Mvk3vLy6QN59a9Olc0xomnVvBz9JPONLFct66?=
 =?iso-8859-1?Q?0Bho2gxJLWW/K0zBfA+IX0I6oElXZaBx8TgiqyYDlmzsjEyOm3vs3kaweY?=
 =?iso-8859-1?Q?8Zo17GjHW1IM5fe2gtmdvL9vOaSGg2ChmznUdOgArqlChQd6cBiX8HhGzJ?=
 =?iso-8859-1?Q?FempPklfYHlvnUkc4zHEsEi5Ys8Q9MOGKOQYH/XZ1/UR0WqpV2mcGofgQZ?=
 =?iso-8859-1?Q?UjRQ2GDrkHVN94THZqS+IMNJmaFVMzNBt2fI7/FD6TacSrVz9Q9bSZ3uPB?=
 =?iso-8859-1?Q?igmYRRE53wauYR/lChwOGnpCh1SseIgi7Xbs0dTWnOzVisqRnjwQNjElcy?=
 =?iso-8859-1?Q?TkJyIoXerDUiVIYq1liXg48eX9DwEr7aYnO4MoxMEnsWDiROggVI5f9Bmn?=
 =?iso-8859-1?Q?WuqkTcABQkh/gqg31B/lLMuq9VQMz5ZJKMLgRFEytjH9dqaNPlZ5ZmfftW?=
 =?iso-8859-1?Q?S28EMLDdCFJk6ZrR4AX5+bV3x9hMJVzI1gOu4SyUn6/LHmR0AvhXevf68k?=
 =?iso-8859-1?Q?zQppmBsERSww87geZ6ibh6ly/Xyq8JfdXhoG6lxp9gvi0OHcst6Q9hvbzv?=
 =?iso-8859-1?Q?DBkDqppLPXSwVmfALd7P/8IGGpW/OSOLJ5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135c7d47-daa3-4de3-bb3b-08da869907ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 12:55:04.6794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mGbQa2817E6gWyYQoKiJD+ZK/Kbl9hacJOdl11wmhImPIPP2AnAdFrunxDgCfMYjst6fgWHwMqBHSsRMjF+nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7463
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Aug 25, 2022 at 12:38:46PM +0000, Czerwacki, Eial wrote:=0A=
>> >On Thu, Aug 25, 2022 at 12:02:12PM +0000, Czerwacki, Eial wrote:=0A=
>> >> >On Thu, Aug 25, 2022 at 10:41:28AM +0000, Czerwacki, Eial wrote:=0A=
>> >> >> >On Thu, Aug 25, 2022 at 10:16:59AM +0000, Czerwacki, Eial wrote:=
=0A=
>> >> >> >> >> >And why is your version file a binary file?=A0 It should ju=
st be a small=0A=
>> >> >> >> >> >text string, right?=0A=
>> >> >> >> >> not so small, it can reach up to 512kb.=0A=
>> >> >> >> >=0A=
>> >> >> >> >That was not obvious at all.=A0 Please document this.=0A=
>> >> >> >> where should the document be?=0A=
>> >> >> >> in the code as a comment or in another file?=0A=
>> >> >> >=0A=
>> >> >> >In the Documentation/ABI/ file that describes this file.=0A=
>> >> >> ok, will place it there=0A=
>> >> >> =0A=
>> >> >> >=0A=
>> >> >> >> >And how in the world is a "version" that big?=A0 What exactly =
does this=0A=
>> >> >> >> >contain?=0A=
>> >> >> >> it 's size depends on the number of resources it uses.=0A=
>> >> >> >> here is an example:=0A=
>> >> >> >> :~> cat /sys/hypervisor/vsmp/version=A0 =0A=
>> >> >> >> SAP vSMP Foundation: 10.6.2862.0 (Aug 22 2022 15:21:02)=0A=
>> >> >> >> System configuration:=0A=
>> >> >> >>=A0=A0=A0 Boards:=A0=A0=A0=A0=A0 2=0A=
>> >> >> >>=A0=A0=A0=A0=A0=A0 1 x Proc. + I/O + Memory=0A=
>> >> >> >>=A0=A0=A0=A0=A0=A0 1 x NVM devices (Amazon.com Amazon EC2 NVMe I=
nstance Storage)=0A=
>> >> >> >>=A0=A0=A0 Processors:=A0 1, Cores: 2, Threads: 4=0A=
>> >> >> >>=A0=A0=A0=A0=A0=A0=A0 Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00=
GHz Stepping 04=0A=
>> >> >> >>=A0=A0=A0 Memory (MB): 30976 (of 103192), Cache: 7527, Private: =
64689=0A=
>> >> >> >>=A0=A0=A0=A0=A0=A0 1 x=A0 6400MB=A0=A0=A0 [ 7825/ 321/ 1104]=A0=
=A0=A0=A0=A0 =0A=
>> >> >> >>=A0=A0=A0=A0=A0=A0 1 x 24576MB=A0=A0=A0 [95367/7206/63585]=A0=A0=
=A0=A0=A0=A0 00:1f.0#1=0A=
>> >> >> >>=A0=A0=A0 Boot device: [HDD] NVMe: Amazon Elastic Block Store=A0=
=A0=A0=A0=A0=A0=A0 =0A=
>> >> >> >> Supported until: Aug 22 2024=0A=
>> >> >> >=0A=
>> >> >> >That is crazy, and is not a version.=A0 It's a "configuration".=
=0A=
>> >> >> it is called version for history reasons...=0A=
>> >> >=0A=
>> >> >There is no "history" here, you can create whatever sane interface y=
ou=0A=
>> >> >want right now, there is no backwards compatible issues involved at =
all.=0A=
>> >> you are correct, however, it depends on how much change the hyperviso=
r code requires=0A=
>> >> if any (latter is preferable)=0A=
>> >=0A=
>> >I do not understand, again, what tool consumes this today?=0A=
>> there are monitoring utils that parses it.=0A=
>=0A=
>What exact tools are you referring to, and why can you not change them?=0A=
>Where is the source for them?=0A=
>=0A=
>thanks,=0A=
>=0A=
>greg k-h=0A=
=0A=
SAP has monitoring tools which parse this configuration text.=0A=
for example exporters integrated into Grafana. these exporters we will chan=
ge=0A=
to support the new format.=0A=
=0A=
Eial=
