Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D19058EC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiHJM7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiHJM7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:59:30 -0400
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD99792F7;
        Wed, 10 Aug 2022 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1660136352; x=1691672352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h5wRRP8FuRuh/VDzUgusrJBeHC8ggm90D/V0UM3CW50=;
  b=Z0fcGfNcIXDiYr147EPq9BaWDxPStAffLvgLPoiJl6JIAY7xKz2wuWQ2
   fuVFxuEhq5hRp/iQoDI0djtL50ypIH96/SX4tZsui/6B/VCzj9IsZqGLw
   nV+RRZTMnhusrAsRkyUob2GjCPECurPysLdCWUJp2Vc+5yMvl/4EgLAE0
   k=;
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 05:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jstCzDOVgYplL0WXy7BXgwfbbo6VJFE9pXtH9NB+5zMmLIjwG9bmm2DxcnaqU5X4N0ULAGX8nboh2FMjgXmcvikF+LgsZrab1wE11+RY04bzqrA04hN/SKjDNW6tFnY0F18Bw6EyVvpw2autJUty8IneRKpmuSC2+hzzK15On7lbrRDTZpbrWrx3ybtKOnfoM3KQ1Lm1WO8E1xpDGiPCCq9ZMJRupp8lofUUoCrg9z6fTjREmDTCMZEYG7XgFzQzeUJi8pj/WVfZhJl5XYU7pv6jcDbg3ownGNse01npt0fTks+0d6h2QxN6SU/ZGchrdY7MjstlymFUjdOkAdk0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cVgadshhZmrarTDbXE1P1TI1YERzVSZxhBBxQEdpPg=;
 b=BSgHW2tdkMYbK6OqRcC/Lns7ytWXmLJJK3U/ZSi2KQBgzmcAPMcWGeeinMfLN+j+aGwaNp6uq3n5LNMCND89M0qZQTMELGLtXf7dFiahil8mIBQQsAr+gcYi0xq+DaGflaW9+30cLt+gKH207V8190rUwiC7RHPCiCcBpXBiyyTmUX7/HGlI2JnM/JMtuIVGGz78oHljWzsE7MePEbAFDXZYu6InkYXNpI5blBi5wEhLezkkB01sG9iehMP08AlO1OpWr/JvVd4lyorAdEf/csNE0QaSVBcvToEXUUbop1QmipufQJ2abBBlDcpWYa38w5ToZb3MlVMBOO7Nga3xhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cVgadshhZmrarTDbXE1P1TI1YERzVSZxhBBxQEdpPg=;
 b=JovdSWgsR2JUHaDVHukk+fGOEKv4Rn/tqqnQd8eyl1ddSa525bPDIuBtClMxkRUyXlakFgPex6WiUOqxzqJ2I93liN45GyPZDE6MO8k8SVUMUARLyU5SoBAh/tFw2Hp3mIjvVCTo8QiZ+wtah65UHeaxX/eJPW2N5Bbqv0arqnI=
Received: from SJ0PR20MB4409.namprd20.prod.outlook.com (2603:10b6:a03:42c::20)
 by SN7PR20MB5333.namprd20.prod.outlook.com (2603:10b6:806:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 10 Aug
 2022 12:59:08 +0000
Received: from SJ0PR20MB4409.namprd20.prod.outlook.com
 ([fe80::b456:9aa0:e357:31f5]) by SJ0PR20MB4409.namprd20.prod.outlook.com
 ([fe80::b456:9aa0:e357:31f5%8]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 12:59:08 +0000
From:   Rory Chen <rory.c.chen@seagate.com>
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Topic: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Index: AQHYhxl16wZu53I2nkyhDu//lRykYq2Hfy1sgB6yWuSAAgaVgIAAJ4jq
Date:   Wed, 10 Aug 2022 12:59:07 +0000
Message-ID: <SJ0PR20MB4409EA5AC40DE61ED7A4BB13A0659@SJ0PR20MB4409.namprd20.prod.outlook.com>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
 <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <74F8D5E8-0D56-413B-A3CA-7462D9C862D6@linaro.org>
In-Reply-To: <74F8D5E8-0D56-413B-A3CA-7462D9C862D6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2022-08-10T12:59:07.284Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8ebd8b9-27b7-40e9-0975-08da7ad01cb9
x-ms-traffictypediagnostic: SN7PR20MB5333:EE_
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OqTivfrpVQJld0rYm5b8eqY635rTa6cHJdoSVHVs8RynUqZUhbIgG6iXLhDc5MWsd+NE/zyn5wXZzrMizBWUlWhLK8k2qxXt9OOaaKhaEeRX2bP92KqC8ZrIEFrkUTCFDhADPLa25Z5TAslrWItuaC1hPdXO9NO9PxPM+8+BIHDXphhR8c+lPJx3gcWebhoFW1G8UfHa5h0DePz/TQUlxpBkaxWA6wmwrdFtCZachhzGtT22IH/DQEKydpGTYsn5iAuuL1k4NVIBZY+2PcvA3c/BW+ghtedJ7IQ4FA+jnFb4VaiQbUn872JGCy/Ep6AOlqe8ALM7G9s0J2xNhcBTRcc3VhIMzttx2Kz74hxF8Rq7ZKzVj8qlwZ1Wkvi+i1+rgLUE+rhux3uq6j2KTr9p7Z4JJet/rckVbByzXyoEpQLYfWbBuw6TuKwwVtIF9Ev6/eh0xfJNoovT/TyGFMTWCZ/2PMRqT/i10HD21+K12g8siGOBbFx7dWE5gcRycMrJcjQdeMfx75Yx4zlp/qSq06G4mGAK2XcCGs+wSdH8x0f87fK5LrZ71+K+Sz2WhoGVqoS3EDbI6J7L2FREQWCch4VyD9mJykwK19u9QNoO6ip/vG2LgJ1xhVmF0c2YtfZ2RLW+wE8tJqU2Uw7GWH1MVb0zbWISEpmlPkRwUyRQwDAtsmklndD7SU6oVRyGob7WYUQwVk2IuicFfEpsCD5wpQN2v4mmVj9NJp0PkZGT9MusT226w7XBjKGpuEwW/yqIoA+3PYGsuTOSC4AtIZ9v/9giGck0Ns9OoLU3QGIFe5bG91fLfFbsp1Cag1Lw/GuUjMNFzMT4AE/S527JO8OrEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR20MB4409.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(396003)(366004)(39860400002)(26005)(9686003)(7696005)(6506007)(53546011)(83380400001)(186003)(38070700005)(107886003)(122000001)(38100700002)(8936002)(52536014)(5660300002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(55016003)(2906002)(966005)(71200400001)(41300700001)(478600001)(91956017)(316002)(54906003)(6916009)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?g9ExV9u42H96tl0IUZVT6neYbgh0b+GRqVFS1QsdujUN+giXvev+yflX?=
 =?Windows-1252?Q?dQqm9LVT/kZYubRvwmbWokJo6NJa9bLi3Ximhecrrtl+vJbHp8DtQdTA?=
 =?Windows-1252?Q?UpdOFLCLgqgcxHQk7ulaO7zllu79sTlcuQuHR1tyeTuyBLTxmTcVsBU0?=
 =?Windows-1252?Q?alfvZ45y9ZWl7jmJ6ahCLgAla/LcuovTr3Qf2jSEvLPphR51EvMUO8OV?=
 =?Windows-1252?Q?PKXsuk/g8dTkgSz9iee5pmlQ+BOFQWJuuXaC0QyOM6dFyWKDl07zymIg?=
 =?Windows-1252?Q?heeC2E4vfWxKNqJn5ak6oaUI0y8mf39F+K2vScN7ClSGoXddzzohA6XV?=
 =?Windows-1252?Q?wvqfmt4Dzg7DmKXAO1Qg8gzYmJCbJu33mTeEVmlAAT5lJRoCWdBQnYgH?=
 =?Windows-1252?Q?OAIYjF03g1rUG1hV08UHE41nTEvti3BG1XE/V9gjHayGYXC91ZKMpVoP?=
 =?Windows-1252?Q?O59TGIe38AtjkGnxo8AaxN6yYXy6vnNE4babxmkt+ZCwsNWky66nL/5M?=
 =?Windows-1252?Q?IVq7dzsqKHPyn5KDh1qdM0OSF4KqdGuAZBm1WVOtjntJc67sz2XfstlO?=
 =?Windows-1252?Q?KNLat9hOy2IJvazl/s9vEawI0/t+W4FzPeOMkoGY66IpcnDZrdHgO4Sy?=
 =?Windows-1252?Q?pzBvHvS+MM6Y6v3oTiQF4TzUTjiT8k7dUkrfTleNj69dtU+cUGx4NGXg?=
 =?Windows-1252?Q?yU69VDIqYyWrt4tAS1aD9hK9b7A/AER8vMeYd3vXkYyVomlFps+na1e5?=
 =?Windows-1252?Q?zF5GPBH3jb8rYgdxKKYBjRLqFMPnMEfEc2XOC/kPp2LSQiGSNQqv+yy3?=
 =?Windows-1252?Q?A7T0d35xTldsNteIsxXbbv2ixEFXHb7cD2lcbq/2VYmQI/D8APFt5yhU?=
 =?Windows-1252?Q?qel/wx9RqIGZ8etnbnBQFKGYjc1URLlJp8tN3j+puvxE0TvIvgbNbzIe?=
 =?Windows-1252?Q?p7+l5/yCSAVTaWWb6LprndLZVy0Hm8FWRymgjgUS8fHqGbP9Ro3HAHhG?=
 =?Windows-1252?Q?I7KZiWd2RvE3hcO8bjX19yGoc0bO0bkTH8yfm0uZl+1xmVUl0Drhpkyr?=
 =?Windows-1252?Q?X1+RktPGRb6/7KAVLp0b04ezRXyJAMmwstl5SISJPxDLuV6kchs04AIF?=
 =?Windows-1252?Q?enTq7FLY/TqXc169V6T3heo443Bu6P1ZhRR0feCiXsB3cKsLOPsBkmTd?=
 =?Windows-1252?Q?kxxgdz6ZStAqI38YUSN2mFjc87exNowWOCitBVBSfwFJqrU0DqMtUxQl?=
 =?Windows-1252?Q?kkwEJFf0zUjozNk63VNN+mtB1XTP7WajjkFH1m2B+EIxQxTOa9SXYthv?=
 =?Windows-1252?Q?BNoar/Irfznha7bjm5vbo7hZUilZ5Z5qUlUxNe9CKRiY/RfUhtA5wqnO?=
 =?Windows-1252?Q?WhoEsfgV/+9xbz8SSMXb1SHXoP0XiCTJIiHaobRsvgySYyLSdkc3UJ/A?=
 =?Windows-1252?Q?1Ol1PBDy1bFbNXRG2Qfmy6Wt1OwLEIqrTEaCv67R0eMfTpp4ESV+RZOZ?=
 =?Windows-1252?Q?/TTgAv0uSAwVCrKZI2WlBuK9pqxf+M8bL/4K8xV+FpOoEnD0NwSS+0IL?=
 =?Windows-1252?Q?sYFI68nOCbok/75TRZs1el/iT0anZJdYAZaCWhcvcXgoguCkq7wadaPg?=
 =?Windows-1252?Q?y9YwbZUdlMNDOS/2+Qk/ve7ShNXcJruXMF+QDLdx5HyhaS2bZPBP7yLZ?=
 =?Windows-1252?Q?degdyzoF5trxsV2RrHBROYQkiQcFn3Qo?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?Windows-1252?Q?GwymXRzPj3UYo8FwYEL+RSbulnswndadBEPCRDh8E3kXDhkIaLwg/Cr9?=
 =?Windows-1252?Q?GKfWazulbI2rIwHJdIgLUQKvrRqeQMBLUmzn/6j3xsG+aldxYf5z/i3v?=
 =?Windows-1252?Q?WcR0sFw/8uMhzv9KQYEZAd3LhsZWsCfy4Mi1ZzAyhSaEYvfqMrDhP5fo?=
 =?Windows-1252?Q?cI8EbzfQ7pAr/gjuPftEJU6EZGcO2EU+0sR4x9/NpuBaiMTucj4kNYRL?=
 =?Windows-1252?Q?Uu96EmlSvzqAmtWh3mI+Lp7QmNeXq7zLalghMUwtgoA7PWfp05VX/usi?=
 =?Windows-1252?Q?7E7Mjq/QTILj48+p08M2Zz6xMdVZdnujaJ3tu+3G2YRpkp1bA5yGWGml?=
 =?Windows-1252?Q?3cMjPnwABMvdd7sr1EcJZSY/vmU8J63055iW1CMQ0wPQ+GIJwPAOijWQ?=
 =?Windows-1252?Q?LgSAKMG2eFCnApcTSLUYT82pqftecaHXjlHN4lFAoLYZTB0Z7C/2ZGsu?=
 =?Windows-1252?Q?bjSS8GdNSDa2l8kPoRYR12x9s0eVsJsaf+i3jwI+PwQdKvgkujcHVL2n?=
 =?Windows-1252?Q?p9W75hiQpIRFVgzGCEazmxVFPQ8AohzdS3S5nAl61YruasYcumQRmHk/?=
 =?Windows-1252?Q?Gs4h2ii1/1UCmZRlGA8ajBkq4IaHyoSbHcL33WFP1eKtsvEGJ0PP6Ljc?=
 =?Windows-1252?Q?3NuB3d0ltlVfJ/DDBc9rpCJWD4PB8GN+hZAq/PpL+kj3in++ehyCzTjb?=
 =?Windows-1252?Q?OcWoQ8Vg9B2JTe9ziFcqAG5dHmdN4+HwbYCC19Wo2HlQX1P/17rvJRl0?=
 =?Windows-1252?Q?s3YRf8SADaQZAzPx6Wi9QZNWo9BvnEuyTk3TzgE7HdstQLTaVaR+3Y60?=
 =?Windows-1252?Q?Xhn4hklTpLb9LhkL0iIJcnbYHHC7uesnlxIufX2WUb0B6OtvPY5X9p1I?=
 =?Windows-1252?Q?s/nhCXpc7I3tAx+2uBpz84TKdsB3XU7W0xXvjNXpvOqveO71T6meoHtx?=
 =?Windows-1252?Q?aLZwBnxUZqlsKGyQGrRd3IA6gc2Dom20ReEXZXc1Wf2vuGbKIWMHdg3d?=
 =?Windows-1252?Q?v+rjI7bfJANzGKcZYrXoyAsVHm4n2sPsAB4/MFkinYaOelMU9WD3tgty?=
 =?Windows-1252?Q?x22Iv5VjEtPgabj6mNNa9U2jNIuTGVlBeDBE4QSRCpwhVyuvCYI6GZL1?=
 =?Windows-1252?Q?oIN88xAOqML3ZMMIrZgtKKTIntsWiy+/e1XQHvTD1zt55A=3D=3D?=
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR20MB4409.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ebd8b9-27b7-40e9-0975-08da7ad01cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 12:59:07.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzITPKqDwPjbGaRHR09K4r+ccF8UVs0NDdfNwjrNVaqrINwbf75lEnrEqsIr6ANCq67ErR/yD4IT5fMp4OvrMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5333
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block trace shows the start sector is 35156656120 and transfer length i=
s 8 sectors, which is within the max LBA 35156656127 of drive. And this IO =
is completed successfully from the slice of parsed block trace though repor=
ting the warning message.
 8,64   7       13     0.039401337 19176  Q  RA 35156656120 + 8 [systemd-ud=
evd]
  8,64   7       15     0.039403946 19176  P   N [systemd-udevd]
  8,64   7       16     0.039405132 19176  I  RA 35156656120 + 8 [systemd-u=
devd]
  8,64   7       18     0.039411554 19176  D  RA 35156656120 + 8 [systemd-u=
devd]
  8,64   0       40     0.039479055     0  C  RA 35156656120 + 8 [0]

It may need to know where calculate "bio_end_sector" value as 35156656128. =
I have patched libata and sd driver for Dual Actuator.



From: Paolo Valente <paolo.valente@linaro.org>
Sent: Wednesday, August 10, 2022 6:22 PM
To: Rory Chen <rory.c.chen@seagate.com>
Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad Ahmad <mu=
hammad.ahmad@seagate.com>; linux-block@vger.kernel.org <linux-block@vger.ke=
rnel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Jan=
 Kara <jack@suse.cz>; andrea.righi@canonical.com <andrea.righi@canonical.co=
m>; glen.valante@linaro.org <glen.valante@linaro.org>; axboe@kernel.dk <axb=
oe@kernel.dk>; Tyler Erickson <tyler.erickson@seagate.com>; Michael English=
 <michael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; Varu=
n Boddu <varunreddy.boddu@seagate.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


> Il giorno 9 ago 2022, alle ore 05:47, Rory Chen <rory.c.chen@seagate.com>=
 ha scritto:
>
> Resend the mail as plain text because previous mail with rich text makes =
some mess and forget to add others at Seagate who worked on validating the
> patch as well(Muhammad, Michael, Andrew, Varun,Tyler)
>
> Hi Paolo,
>

Hi

> I am from Seagate China and face a problem when I=92m evaluating the bfq =
patches. Could you please check?
> Thanks
>
> Issue statement
> When running performance test on bfq patch, I observed warning message "b=
fq_actuator_index: bio sector out of ranges: end=3D35156656128" and OS hung=
 suddenly after some hours.
> The warning message is reported from function bfq_actuator_index which de=
termines IO request is in which index of actuators.  The bio_end_sector is =
35156656128 but the max LBA for the drive is 35156656127 so it=92s beyond t=
he LBA range.

Yep, this sanity check fails if the end sector of a new IO does not
belong to any sector range.

>  I captured the block trace and didn=92t found request LBA 35156656128 in=
stead only found max request LBA 35156656127.

Maybe in the trace you see only start sectors?  The failed check si
performed on end sectors instead.

At any rate, there seems to be an off-by-one error in the value(s)
stored in the sector field(s) of the blk_independent_access_range data
structure.

I guess we may need some help/feedback from people competent on this
stuff.

> I=92m not sure if this warning message is related to later OS hung.
>

Not easy to say.  At any rate, we can try with a development version
of bfq.  It can help us detect the possible cause of this hang.  But
let's see where we get with this sector error first.

Thank you for testing this extended version of bfq,
Paolo

>
> Problem environment
> Kernel base is 5.18.9
> Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
> Actuator LBA mapping by reading VPD B9
> Concurrent positioning ranges VPD page:
> LBA range number:0
> number of storage elements:1
> starting LBA:0x0
> number of LBAs:0x417c00000 [17578328064]
> LBA range number:1
> number of storage elements:1
> starting LBA:0x417c00000
> number of LBAs:0x417c00000 [17578328064]
>
>
>
>
>
> From: Paolo Valente <paolo.valente@linaro.org>
> Sent: Thursday, June 23, 2022 8:53 AM
> To: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; linux-kern=
el@vger.kernel.org <linux-kernel@vger.kernel.org>; jack@suse.cz <jack@suse.=
cz>; andrea.righi@canonical.com <andrea.righi@canonical.com>; glen.valante@=
linaro.org <glen.valante@linaro.org>; Arie van der Hoeven <arie.vanderhoeve=
n@seagate.com>; Paolo Valente <paolo.valente@linaro.org>
> Subject: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator dri=
ves
>
>
> This message has originated from an External Source. Please use proper ju=
dgment and caution when opening attachments, clicking links, or responding =
to this email.
>
>
> Hi,
> this patch series extends BFQ so as to optimize I/O dispatch to
> multi-actuator drives. In particular, this extension addresses the
> following issue. Multi-actuator drives appear as a single device to
> the I/O subsystem [1].  Yet they address commands to different
> actuators internally, as a function of Logical Block Addressing
> (LBAs). A given sector is reachable by only one of the actuators. For
> example, Seagate=92s Serial Advanced Technology Attachment (SATA)
> version contains two actuators and maps the lower half of the SATA LBA
> space to the lower actuator and the upper half to the upper actuator.
>
> Evidently, to fully utilize actuators, no actuator must be left idle
> or underutilized while there is pending I/O for it. To reach this
> goal, the block layer must somehow control the load of each actuator
> individually. This series enriches BFQ with such a per-actuator
> control, as a first step. Then it also adds a simple mechanism for
> guaranteeing that actuators with pending I/O are never left idle.
>
> See [1] for a more detailed overview of the problem and of the
> solutions implemented in this patch series. There you will also find
> some preliminary performance results.
>
> Thanks,
> Paolo
>
> [1] https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpYe=
PrA0GTWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08LRiTVo=
IOUC8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0ByLONHEoI3p3e=
9QNIn6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895gYBFn5S2WjBDQq2kz=
DzZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVREEVa1b6bQByX6grF5pn3pT=
Io0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74WIKDrNTALs3xQvg03DH4jLez-T2=
M9xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%2F%2Fwww.linaro.org%2Fblog%2Fbu=
dget-fair-queueing-bfq-linux-io-scheduler-optimizations-for-multi-actuator-=
sata-hard-drives%2F
>
> Davide Zini (3):
>  block, bfq: split also async bfq_queues on a per-actuator basis
>  block, bfq: inject I/O to underutilized actuators
>  block, bfq: balance I/O injection among underutilized actuators
>
> Federico Gavioli (1):
>  block, bfq: retrieve independent access ranges from request queue
>
> Paolo Valente (4):
>  block, bfq: split sync bfq_queues on a per-actuator basis
>  block, bfq: forbid stable merging of queues associated with different
>    actuators
>  block, bfq: turn scalar fields into arrays in bfq_io_cq
>  block, bfq: turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
>
> block/bfq-cgroup.c  |  97 +++++----
> block/bfq-iosched.c | 488 +++++++++++++++++++++++++++++---------------
> block/bfq-iosched.h | 149 ++++++++++----
> block/bfq-wf2q.c    |   2 +-
> 4 files changed, 493 insertions(+), 243 deletions(-)
>
> --
> 2.20.1
>
>
> Seagate Internal
>
> Seagate Internal

Seagate Internal
