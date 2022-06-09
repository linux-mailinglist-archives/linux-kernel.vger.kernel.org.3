Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCF1544307
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiFIFSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiFIFSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:18:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EA619F9A;
        Wed,  8 Jun 2022 22:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654751918; x=1686287918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z3u5No7uXTJfAX6PX+5uU3u4DuAErVKX3mBKS97bHVg=;
  b=0ibu7U9H65mJa3naNI207ecOzxsuMUtBAvtqpR7nRxVFq1w5u7kVnO4Z
   74EtUM/0qBxdXJT41o/0hbTgdJjLvPaScsmHcFli+DRb4H5twXg+tZ0NR
   dAXOmdexiSapsoMgpUcc0bHml85amuLjGOjtESQQrW0mRoQVDlf0W1IjQ
   hxPbbsDYzFLHWllNlm22xghs/Z0T1XB8Y+rBPFD5zcssEKlC/CdsRRtzu
   l5tkoaLdefdeIY+mGIxQeypxd622QBvHrGy9Q2BqD+akCJXaAppo4HjQv
   VcyHHIX18X2zqnyYP7W+J79r3B0REFNTg+/Yz/1wvwjou2MpEN+oWRvfk
   g==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="167702846"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 22:18:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 22:18:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 22:18:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avuPo0aIgAfWjSwdO8KumnTvRFZ3Pvya9yt8Re23/1FUYfacmAUJ7A2gBNoFngxql8EOrBc8CYREK0W9PQ/RvopU4Y+sw0UuXGQCYNYYJyIqW1gIRHq3yF50gBfwrRci/NBWv7nHZtp9girnSFmZFU6jGL46OHgTS5j4oO4Slv4Olu1ELwLU2nCS0TcsoVOjEvllSjztbOtS9SVXLcqTqrPIr1cCWnTsaSjJjrkAoMZXQ/XeyYQo407eMiY7iJc2f1Z4TnnKyaUxBFoPzJen7eTMQcFZcL+1Zw8mMFFJlxxkd/FFGc5ivPYHPwIZKIDE5UMNxB+WCuqV2lW4DN4fXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3u5No7uXTJfAX6PX+5uU3u4DuAErVKX3mBKS97bHVg=;
 b=oWpmrULO4hUDxBzbNZVB3KtG9OK98rLY+SaVronuCl1EkfojLsvZkFAmGtMLzoKcMrJJ9WxU0+SHMei+H1ROhjEzkG/cIpiDX3PZ7F5I45XP5J9QhMzmP81YJBIAxghxaSw1inRghmiZJ8DAsJKfr0aBG6ZQG/07+XziWou3H06SEZRd6AOQPx9VVQXY3UCYGRbMmA85zykHgIJ5AicEeU83bhEILPwGjz13OigFx+JTWFXOFcvNvp/FbEkiGbmxAyQVTQ0QhJ4DdEq1J+vUtSkd/0t8xD6ykoPs3+xsCsWKBLJVKNF2R/hhGylePhvarXQATUlG7TJcDWbImphuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3u5No7uXTJfAX6PX+5uU3u4DuAErVKX3mBKS97bHVg=;
 b=lwynYqUcYP9BeWlsixC+5CJUo+rAe1LtdAJx+eDjZvKtWKZWcWJhwSJB4xlpRj1dfeNJGyn4xBTqpyhnDVzE1nEbii4RQDDNWgO4epKxFM5P0bx3bX8XGauBHFTnIvEH8k0zL+V3Rt41ZvDIAVa1oDCKrhozY3IBA8RgBLxDO2M=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by BYAPR11MB2680.namprd11.prod.outlook.com (2603:10b6:a02:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Thu, 9 Jun
 2022 05:18:28 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a%7]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 05:18:28 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: RE: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Topic: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Index: AQHYen2xLy/v/QXVdkSn5wTBKfw+1K1FH4sAgAAIsKCAAGfPAIAA9k/g
Date:   Thu, 9 Jun 2022 05:18:28 +0000
Message-ID: <CO1PR11MB486542298A4208581AD8DCBD92A79@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-4-kavyasree.kotagiri@microchip.com>
 <9cf14336-16c3-5df5-b235-3f988d8b5151@microchip.com>
 <CO1PR11MB4865879F14D49AF7550C2D1192A49@CO1PR11MB4865.namprd11.prod.outlook.com>
 <c3a17994-72dd-8b64-4ddd-9deb3c793e24@microchip.com>
In-Reply-To: <c3a17994-72dd-8b64-4ddd-9deb3c793e24@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5a9fcd0-6e35-46b8-68df-08da49d77c8d
x-ms-traffictypediagnostic: BYAPR11MB2680:EE_
x-microsoft-antispam-prvs: <BYAPR11MB268044E239E183E7263623C492A79@BYAPR11MB2680.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lxsK4MQyfUOFjDbyDxc8XZTbLa2TDYOUidbL0ncgY9LYgINBhRSU9O8cv4jyIlqJMEnzVWCizJzWUE5XueWLlgDwYeFP72UHO4ninT4/g0QPxPE1acKa/GGtu3g/LqiLHEqVRrjIjD9Q3H2VHnYnxU0GxutrngxSBUPjVsiz55PLDat19VPzI7YqeNOqa1e04/fs5CkfLDrIdspR5MEyeVSkraGMduoSAkmbbTZkFM0xcVCYESXExGCOi9CXIOXn4Hbd+e40kiurixww94eY2PssaVzS5eSbyO7IoWU8V1/+d0+SBx5vg6zBncpEq/ILRU+4G49q1ehfs7D1cMTaZ9JUsStXO5H7vQObcuspKRfiQN1VyvvGkfn+ksqs/e8q9MCmEmxxT35k/xeg6pBeqXDMsNqFxpXTcTzCjpzez2xkXsbQyzzu7nD/3PH3NIrxejwFU/6Vs4Q004bgWE4/lYHK13KP45Od+pQtE3wC3KY+s/hhTnftDPFjklgOTebg/Vgj1j2pEa8dsjKzo2zY3/ZXHJgYFMH+MdAMN704LcPbqeApehdYewhOpVHGYfGQtA8DK3L4IUHgEru985gddFEqIFwNRgvZScu9Ahv7MYu2prCxAHoJ+pDLfqRm7+MQjPS9NaEQ7loakKyW+prB4jxabq+yfOcqvoedpb7mAX3BTHuT6Cop+snmGpT6m5ZoAmxG4tPEpfUm8P5Nj81ODdCal3UsSQt8XRKMIRMboKvS6GkaaBaVleFMjm5BIKQvgV66Ck0eLHzeDgGZwDq5ZS99iSWBRwflzj5DFSe6X1SP5KyFiS1lUOKlTWc2Y0e1XdWuJjfsPLotJ6wjeBhsEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(45080400002)(54906003)(66446008)(86362001)(966005)(508600001)(186003)(5660300002)(66556008)(66946007)(33656002)(76116006)(64756008)(4326008)(8676002)(6862004)(52536014)(8936002)(66476007)(6506007)(38100700002)(7696005)(6636002)(71200400001)(83380400001)(316002)(38070700005)(55016003)(26005)(9686003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2dmWXAyTUljR3VnU0c1M0FGdEcrWEJqWUR2ZHdZZlJqREU4U2JVbXJENVc2?=
 =?utf-8?B?Z21jVlBFLzdWeEFlZkF6NUlSYVdwWVE1cHNxWGFUN05KVnFWd0dWUW53dnRj?=
 =?utf-8?B?SXgxcm5CWWtOa0t6cFFONi9NZkpqTnlURmtDcEkrc1NMRVEzR1pIMFVhRTFF?=
 =?utf-8?B?bDBsblM5azV3YmdxSk1oWEVIeTFhbWhVNWpLNmVpUkpIMHVJdHBVYmdEaURz?=
 =?utf-8?B?VThkdDJKTUpocXBUVUZPZ1Q1YlJTL1IyYnhhQ3lpYzJ6cmJPbXp1bXcxWWhL?=
 =?utf-8?B?b3NMSUlZQXh0QXJmTFIycVpiOXB2NC9UaU5BdXF3YnF0TjNZMkdkem5Dc1lq?=
 =?utf-8?B?WmErd2FqT2g1WFBSTVNiUkFXaHpJQ2ppN2VzejJaRERMSW9kVk9RdFNYaWFL?=
 =?utf-8?B?dXlXdnFaeklacjFRZzVkYytQS3k3bE1QSW9nZWUveWYxTjVQUnNYWkJiRDBH?=
 =?utf-8?B?QktmMTkxaWtpVUZrVEl0Q3hoUUN4bGh5cnplamVBYXZBOGRrRFdVVGFPUGcw?=
 =?utf-8?B?SWlxVWRqM0s0N2xrT1llSEZjR2lDL0w4bXFPdzBMamlBWi9KanRMamFGWHVZ?=
 =?utf-8?B?Rkwyc0tKN0ppd09wZ3Z6VkpjaVZPRXdMb09abzYwSG13Q3ZjUThVa21KWlUw?=
 =?utf-8?B?bjRyNzhRM2R3ZURISUg0R2RQMHJVcm1ZenQ2ZGlYQ3NFUXNpK2Z0ZTc3L2la?=
 =?utf-8?B?UVNvSDVWK2VIUXF6SHo4c2ZGZzdUN1ROTXB2ZUhVZWRuNnBldkJIZXpXR0NX?=
 =?utf-8?B?QVRBSGlJeUI4Qm00cS9DL3ROTURFb1dMMmlBMkkrMUVSQjRZQzFuOWNlaTVm?=
 =?utf-8?B?T2kyalFZU2h1cFBhdHBFR3BMTTlWSFMxamYyUXVCNFk1U0lzS0d1WkNnRElz?=
 =?utf-8?B?d3dFLzdySHdLNTVJbzVBVzA5VjdmSktKU0ZCTG9TNnQ3cWhjcXVBNXh1Rmlt?=
 =?utf-8?B?L3lDVCtjNzVrOWZvM0tKbXFETEFHcGRWS3llaHlEalBzMHMxL3R6YU9GZUIw?=
 =?utf-8?B?bmcrYU1NVm5UM1BrUi85NjQzSGgwR2hyZFUyLzdsbHpVNythbTVSa3FSVjRz?=
 =?utf-8?B?ZWFxUDVES2NncUwrN2c1MThUWkRSQXRtMTgvOWNtQjh6YkZkWXV4c2JkVEZH?=
 =?utf-8?B?VmJtOEY5Mzc2cWtzMFljMlJqU29tQWszN0RoNXBvMThmSnNxSnNtTWh5VjJ6?=
 =?utf-8?B?aVlGUHNvNlRJcTM1Tld3bjZxYkp6QWhWVmg2WllxazNKWHBwTXBINGJRNzZQ?=
 =?utf-8?B?QTNKOVE2OWpSMzh0OGk3VjducWtrbCtGMGsrbHpieDBSR2tGa0hLQ1k4ZE1w?=
 =?utf-8?B?cHhDYldHamI1U0NpNUtQcHR4TTRVUDg2amdPTEUzNXZjbWxZb0ZFRHFjdkxJ?=
 =?utf-8?B?Q05oWUExRmw1a0VlYmNFOTVxMDB0OFd4QjdrRSsxeUVhRnpjTlFON3h4azIx?=
 =?utf-8?B?RzBtdVEvZWZxYWlLTDhBUWh3ZVpwWm5JRmc3cGFnSnliVGFIenB2TGllUGZz?=
 =?utf-8?B?WERsVkc5b0gvZDl2Tnh0YThwWGFVNDEzV3JGU3NYQ2hZb3dWZmhvQVAwQ1lG?=
 =?utf-8?B?UlJOdHVUblNJRDAzejhOVUhJemprYmV0L0srVVF1VjQvSFk2ZHhKc2ZQd1Mv?=
 =?utf-8?B?cG93R0dJejk1T0l2dlVmblY5d0h6QnV6ejB6YjduZFdIYXp1eWdGWE9WK0Nl?=
 =?utf-8?B?UW44RUk5VGc1OUxKN2Z6emRjaGZPM1VwbmlvU3Y3Vkt3aEVEbDFWcEtXV1VT?=
 =?utf-8?B?SFJBTzJqZ0wzclJyVlBQRG5PYnd4WUtid212WjRkYXRxWXJLQVFvVElxb08x?=
 =?utf-8?B?K3hsdXl0ZnZmQjI3eXh0T1drYk82UTJ2SWRZV3RqTkNpSk91WWJiVnZMbFhj?=
 =?utf-8?B?a1VxazBBMEc3cG5DV1JWbmVUeVV1U010eGhUZHIxa2xtTjVXeHkzRVUyV3Ax?=
 =?utf-8?B?NFJGaE1JM1RidkcvdEp6YzMwMlBhNnRPNmZHYTdKWXNxZkNEWHFveTJGQ2Fr?=
 =?utf-8?B?ZDhoeDlxSytaYnFJeXRFVDY2c0ZuenNYWFJxczlaaE1HUVU3MDgrSHN5dFR1?=
 =?utf-8?B?ZEJ2YnVVdkdWcUZ1Z2d4ZlpVbjRZK1hCSFpsaWVheGdKTEc2cWdWeE45TDVq?=
 =?utf-8?B?TERkSEtUVHBFV0JuOTUxamFIQm1nVWt4b2dzRlZTekRvVDFMaDFiNkMwMGdO?=
 =?utf-8?B?eWtzUSsrdElKdEg0QXlkUGxQQTdSZUZTaGhDVmRIWG1YaHhiTmNSVTczK2Qw?=
 =?utf-8?B?VXRKT1ZHbm9raEphd044OHAvWHlIWEx0bDBJNXF2NnZzVnJHSUd3cE4wNFA5?=
 =?utf-8?B?bWkvMktQWFlRZzZ2UDlsZXl2MGcvSFk5bWQvK3d3TlVuOFgrUnBYS0NuWlli?=
 =?utf-8?Q?OY0k2sPlUR+frG30=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a9fcd0-6e35-46b8-68df-08da49d77c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 05:18:28.2472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Drd2ycwRwz3UocQKxZvfyezPmOrnMDubNFiKpukSYVSilQ9bFfkqBJ1MS8Hwk5JjSR5TTF/4lFh/5ZfZE+8GKhSPFIhQvDw47JF1MLJwsWNj8xXYhyVyFEcaJk4fYRzx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2680
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gTEFOOTY2eCBTb0MgaGF2ZSA1IGZsZXhjb21zLiBFYWNoIGZsZXhjb20gaGFzIDIgY2hp
cC1zZWxlY3RzLg0KPiA+Pj4gRm9yIGVhY2ggY2hpcCBzZWxlY3Qgb2YgZWFjaCBmbGV4Y29tIHRo
ZXJlIGlzIGEgY29uZmlndXJhdGlvbg0KPiA+Pj4gcmVnaXN0ZXIgRkxFWENPTV9TSEFSRURbMC00
XTpTU19NQVNLWzAtMV0uIFRoZSB3aWR0aCBvZg0KPiA+Pj4gY29uZmlndXJhdGlvbiByZWdpc3Rl
ciBpcyAyMSBiZWNhdXNlIHRoZXJlIGFyZSAyMSBzaGFyZWQgcGlucw0KPiA+Pj4gb24gZWFjaCBv
ZiB3aGljaCB0aGUgY2hpcCBzZWxlY3QgY2FuIGJlIG1hcHBlZC4gRWFjaCBiaXQgb2YgdGhlDQo+
ID4+PiByZWdpc3RlciByZXByZXNlbnRzIGEgZGlmZmVyZW50IEZMRVhDT01fU0hBUkVEIHBpbi4N
Cj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBLYXZ5YXNyZWUgS290YWdpcmkgPGthdnlhc3Jl
ZS5rb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiB2MSAtPiB2MjoNCj4g
Pj4+ICAtIHVzZSBHRU5NQVNLIGZvciBtYXNrLCBtYWNyb3MgZm9yIG1heGltdW0gYWxsb3dlZCB2
YWx1ZXMuDQo+ID4+PiAgLSB1c2UgdTMyIHZhbHVlcyBmb3IgZmxleGNvbSBjaGlwc2VsZWN0cyBp
bnN0ZWFkIG9mIHN0cmluZ3MuDQo+ID4+PiAgLSBkaXNhYmxlIGNsb2NrIGluIGNhc2Ugb2YgZXJy
b3JzLg0KPiA+Pj4NCj4gPj4+ICBkcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29tLmMgfCA5Mw0KPiA+
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4+PiAgMSBmaWxlIGNo
YW5nZWQsIDkyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+DQo+ID4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jIGIvZHJpdmVycy9tZmQvYXRtZWwt
ZmxleGNvbS5jDQo+ID4+PiBpbmRleCAzM2NhYTRmYmE2YWYuLmFjNzAwYTg1YjQ2ZiAxMDA2NDQN
Cj4gPj4+IC0tLSBhL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0KPiA+Pj4gKysrIGIvZHJp
dmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+ID4+PiBAQCAtMjgsMTUgKzI4LDY4IEBADQo+ID4+
PiAgI2RlZmluZSBGTEVYX01SX09QTU9ERShvcG1vZGUpCSgoKG9wbW9kZSkgPDwNCj4gPj4gRkxF
WF9NUl9PUE1PREVfT0ZGU0VUKSAmCVwNCj4gPj4+ICAJCQkJIEZMRVhfTVJfT1BNT0RFX01BU0sp
DQo+ID4+Pg0KPiA+Pj4gKy8qIExBTjk2NnggZmxleGNvbSBzaGFyZWQgcmVnaXN0ZXIgb2Zmc2V0
cyAqLw0KPiA+Pj4gKyNkZWZpbmUgRkxFWF9TSFJEX1NTX01BU0tfMAkweDANCj4gPj4+ICsjZGVm
aW5lIEZMRVhfU0hSRF9TU19NQVNLXzEJMHg0DQo+ID4+PiArI2RlZmluZSBGTEVYX1NIUkRfUElO
X01BWAkyMA0KPiA+Pj4gKyNkZWZpbmUgRkxFWF9DU19NQVgJCTENCj4gPj4+ICsjZGVmaW5lIEZM
RVhfU0hSRF9NQVNLCQlHRU5NQVNLKDIwLCAwKQ0KPiA+Pj4gKw0KPiA+Pj4gK3N0cnVjdCBhdG1l
bF9mbGV4X2NhcHMgew0KPiA+Pj4gKwlib29sIGhhc19mbHhfY3M7DQo+ID4+PiArfTsNCj4gPj4+
ICsNCj4gPj4+ICBzdHJ1Y3QgYXRtZWxfZmxleGNvbSB7DQo+ID4+PiAgCXZvaWQgX19pb21lbSAq
YmFzZTsNCj4gPj4+ICsJdm9pZCBfX2lvbWVtICpmbGV4Y29tX3NoYXJlZF9iYXNlOw0KPiA+Pj4g
IAl1MzIgb3Btb2RlOw0KPiA+Pj4gIAlzdHJ1Y3QgY2xrICpjbGs7DQo+ID4+PiAgfTsNCj4gPj4+
DQo+ID4+PiArc3RhdGljIGludCBhdG1lbF9mbGV4Y29tX2xhbjk2NnhfY3NfY29uZmlnKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4+PiArew0KPiA+Pj4gKwlzdHJ1Y3QgYXRt
ZWxfZmxleGNvbSAqZGRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoJnBkZXYtPmRldik7DQo+ID4+PiAr
CXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gPj4+ICsJdTMy
IGZseF9zaHJkX3BpbnNbMl0sIGZseF9jc1syXSwgdmFsOw0KPiA+Pj4gKwlpbnQgZXJyLCBpLCBj
b3VudDsNCj4gPj4+ICsNCj4gPj4+ICsJY291bnQgPSBvZl9wcm9wZXJ0eV9jb3VudF91MzJfZWxl
bXMobnAsICJtaWNyb2NoaXAsZmx4LXNocmQtDQo+ID4+IHBpbnMiKTsNCj4gPj4+ICsJaWYgKGNv
dW50IDw9IDAgfHwgY291bnQgPiAyKSB7DQo+ID4+PiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJJ
bnZhbGlkICVzIHByb3BlcnR5ICglZClcbiIsICJmbHgtc2hyZC0NCj4gPj4gcGlucyIsDQo+ID4+
PiArCQkJCWNvdW50KTsNCj4gPj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+Pj4gKwl9DQo+ID4+
PiArDQo+ID4+PiArCWVyciA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2FycmF5KG5wLCAibWljcm9j
aGlwLGZseC1zaHJkLXBpbnMiLA0KPiA+PiBmbHhfc2hyZF9waW5zLCBjb3VudCk7DQo+ID4+PiAr
CWlmIChlcnIpDQo+ID4+PiArCQlyZXR1cm4gZXJyOw0KPiA+Pj4gKw0KPiA+Pj4gKwllcnIgPSBv
Zl9wcm9wZXJ0eV9yZWFkX3UzMl9hcnJheShucCwgIm1pY3JvY2hpcCxmbHgtY3MiLCBmbHhfY3Ms
DQo+ID4+IGNvdW50KTsNCj4gPj4+ICsJaWYgKGVycikNCj4gPj4+ICsJCXJldHVybiBlcnI7DQo+
ID4+PiArDQo+ID4+PiArCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7DQo+ID4+PiArCQlp
ZiAoZmx4X3NocmRfcGluc1tpXSA+IEZMRVhfU0hSRF9QSU5fTUFYKQ0KPiA+Pj4gKwkJCXJldHVy
biAtRUlOVkFMOw0KPiA+Pj4gKw0KPiA+Pj4gKwkJaWYgKGZseF9jc1tpXSA+IEZMRVhfQ1NfTUFY
KQ0KPiA+Pj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiA+Pj4gKw0KPiA+Pj4gKwkJdmFsID0gfigx
IDw8IGZseF9zaHJkX3BpbnNbaV0pICYgRkxFWF9TSFJEX01BU0s7DQo+ID4+PiArDQo+ID4+PiAr
CQlpZiAoZmx4X2NzW2ldID09IDApDQo+ID4+PiArCQkJd3JpdGVsKHZhbCwgZGRhdGEtPmZsZXhj
b21fc2hhcmVkX2Jhc2UgKw0KPiA+PiBGTEVYX1NIUkRfU1NfTUFTS18wKTsNCj4gPj4+ICsJCWVs
c2UNCj4gPj4+ICsJCQl3cml0ZWwodmFsLCBkZGF0YS0+ZmxleGNvbV9zaGFyZWRfYmFzZSArDQo+
ID4+IEZMRVhfU0hSRF9TU19NQVNLXzEpOw0KPiA+Pg0KPiA+PiBUaGVyZSBpcyBzdGlsbCBhbiBv
cGVuIHF1ZXN0aW9uIG9uIHRoaXMgdG9waWMgZnJvbSBwcmV2aW91cyB2ZXJzaW9uLg0KPiA+Pg0K
PiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS0NCj4ga2VybmVsL1BIMFBSMTFN
QjQ4NzI0REUwOUE1MEQ2N0YxRUE5RkJFMDkyRDg5QFBIMFBSMTFNQjQ4NzIubg0KPiBhbXByZDEx
LnByb2Qub3V0bG9vay5jb20vDQo+IA0KPiAicHJldmlvdXMgdmVyc2lvbiIgbWVhbnQgZm9yIG1l
IHRoaXMgdGhlIG9uZSBhdCBbMV0uLi4gQW5vdGhlciBwb2ludCB0aGF0DQo+IHRoZSB2ZXJzaW9u
aW5nIG9mIHRoaXMgc2VyaWVzIGlzIGJhZC4NCj4gDQo+IFRoZSBxdWVzdGlvbiB3YXMgdGhlIGZv
bGxvd2luZzoNCj4gDQo+ICJJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgSSBkb24ndCBzZWUgaGVy
ZSB0aGUgYXBwcm9hY2ggeW91IGludHJvZHVjZWQgaW4NCj4gWzFdOg0KPiANCj4gKwkJCWVyciA9
IG11eF9jb250cm9sX3NlbGVjdChmbHhfbXV4LCBhcmdzLmFyZ3NbMF0pOw0KPiArCQkJaWYgKCFl
cnIpIHsNCj4gKwkJCQltdXhfY29udHJvbF9kZXNlbGVjdChmbHhfbXV4KTsNCj4gIg0KPiANCj4g
QXMgSSBoYWQgaW4gbWluZCB0aGF0IHlvdSBzYWlkIHlvdSBuZWVkIG11eF9jb250cm9sX2Rlc2Vs
ZWN0KCkgYmVjYXVzZQ0KPiB5b3VyDQo+IHNlcmlhbCByZW1haW4gYmxvY2tlZCBvdGhlcndpc2Ug
KGJ1dCBJIGRvbid0IGZpbmQgdGhhdCBpbiB0aGUgY29tbWVudHMgb2YNCj4gWzFdKS4gQW5kIEkg
ZG9uJ3Qgc2VlIHNvbWV0aGluZyBzaW1pbGFyIHRvIG11eF9jb250cm9sX2Rlc2VsZWN0KCkgYmVp
bmcNCj4gY2FsbGVkIGluIHRoaXMgcGF0Y2guDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC81ZjlmY2MzMy1jYzBmLWM0MDQtY2Y3Zi0NCj4gY2I3
M2Y2MDE1NGZmQG1pY3JvY2hpcC5jb20vDQo+IA0KPiA+IEFzIHBhcnQgb2YgY29tbWVudHMgZnJv
bSBQZXRlciBSb3NpbiAtIEluc3RlYWQgb2YgdXNpbmcgbXV4IGRyaXZlciwgVGhpcw0KPiBwYXRj
aCBpcyBpbnRyb2R1Y2luZw0KPiA+IG5ldyBkdC1wcm9wZXJ0aWVzIGluIGF0bWVsLWZsZXhvbSBk
cml2ZXIgaXRsc2VsZiB0byBjb25maWd1cmUgRmxleGNvbQ0KPiBzaGFyZWQgcmVnaXN0ZXJzLg0K
PiA+IEJhc2VkIG9uIHRoZSBjaGlwLXNlbGVjdCgwIG9yIDEpIHRvIGJlIG1hcHBlZCB0byBmbGV4
Y29tIHNoYXJlZCBwaW4sIHdyaXRlDQo+IHRvIHRoZQ0KPiA+IHJlc3BlY3RpdmUgcmVnaXN0ZXIu
DQo+ID4gSWYgeW91IHN0aWxsIGhhdmUgYW55IHF1ZXN0aW9ucywgcGxlYXNlIGNvbW1lbnQuDQo+
ID4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvUEgwUFIxMU1CNDg3
MjRERTA5QTUwRDY3RjFFQTlGQkUwOTJEODlAUEgwUFIxMU1CNDg3Mi5uYW1wcmQxMS5wcm9kLm91
dGxvb2suY29tLw0KVG8gYXZvaWQgY29uZnVzaW9uLCBJIHN0b3BwZWQgY29udGludWluZyB3aXRo
IGFib3ZlIHBhdGNoIHZlcnNpb25pbmcobXV4IGRyaXZlciBhcHByb2FjaCkuDQpJIHN0YXJ0ZWQg
bmV3IHBhdGNoIHNlcmllcyBpbiB3aGljaCBJIGFtIGNvbmZpZ3VyaW5nIEZMRVhDT01fU0hBUkVE
WzAtNF06U1NfTUFTS1swLTFdDQpyZWdpc3RlcnMgaW4gYXRtZWwtZmxleGNvbS5jIGRyaXZlciB1
c2luZyBuZXcgRFQtcHJvcGVydGllcywgbXV4IGRyaXZlciBhcHByb2FjaCBpcyBubyBtb3JlIGZv
bGxvd2VkDQphcyBzdWdnZXN0ZWQgYnkgUGV0ZXIgUm9zaW46DQoiDQo+IElmIHlvdSBhcmUgY29u
dGVudCB3aXRoIGp1c3QgcHJvZ3JhbW1pbmcgYSBmaXhlZCBzZXQgb2YgdmFsdWVzIHRvDQo+IGEg
Y291cGxlIG9mIHJlZ2lzdGVycyBkZXBlbmRpbmcgb24gaG93IHRoZSBib2FyZCBpcyB3aXJlZCwg
c29tZQ0KPiBleHRyYSBEVCBwcm9wZXJ0eSBvbiBzb21lIG5vZGUgcmVsYXRlZCB0byB0aGUgZmxl
eGNvbSBzZWVtcyBsaWtlDQo+IGEgYmV0dGVyIGZpdCB0aGFuIGEgbXV4IGRyaXZlci4NCkJhc2Vk
IG9uIHlvdXIgaW5wdXRzLCBJIHBsYW5uZWQgdG8gc2VuZCBhIG5ldyBwYXRjaCB3aXRoIG5ldyBE
VCBwcm9wZXJ0aWVzDQppbnRyb2R1Y2VkIGluIGF0bWVsLWZsZXhjb20uYyBkcml2ZXIgcmF0aGVy
IHRoYW4gbXV4IGRyaXZlci4NCg0KVGhhbmtzLA0KS2F2eWENCiINCg0KVGhhbmtzLA0KS2F2eWEN
Cg0KPiA+Pj4gKwl9DQo+ID4+PiArDQo+ID4+PiArCXJldHVybiAwOw0KPiA+Pj4gK30NCj4gPj4+
ICsNCj4gPj4+ICBzdGF0aWMgaW50IGF0bWVsX2ZsZXhjb21fcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gPj4+ICB7DQo+ID4+PiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAg
PSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gPj4+ICsJY29uc3Qgc3RydWN0IGF0bWVsX2ZsZXhfY2Fw
cyAqY2FwczsNCj4gPj4+ICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4+PiAgCXN0cnVjdCBh
dG1lbF9mbGV4Y29tICpkZGF0YTsNCj4gPj4+ICAJaW50IGVycjsNCj4gPj4+IEBAIC03NiwxMyAr
MTI5LDUxIEBAIHN0YXRpYyBpbnQgYXRtZWxfZmxleGNvbV9wcm9iZShzdHJ1Y3QNCj4gPj4gcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+Pj4gIAkgKi8NCj4gPj4+ICAJd3JpdGVsKEZMRVhfTVJf
T1BNT0RFKGRkYXRhLT5vcG1vZGUpLCBkZGF0YS0+YmFzZSArDQo+ID4+IEZMRVhfTVIpOw0KPiA+
Pj4NCj4gPj4+ICsJY2FwcyA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsN
Cj4gPj4+ICsJaWYgKCFjYXBzKSB7DQo+ID4+PiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDb3Vs
ZCBub3QgcmV0cmlldmUgZmxleGNvbSBjYXBzXG4iKTsNCj4gPj4+ICsJCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShkZGF0YS0+Y2xrKTsNCj4gPj4NCj4gPj4gQ291bGQgeW91IGtlZXAgYSBjb21tb24g
cGF0aCB0byBkaXNhYmxlIHRoZSBjbG9jaz8gQSBnb3RvIGxhYmVsDQo+IHNvbWV0aGluZw0KPiA+
PiBsaWtlIHRoaXM6DQo+ID4+IAkJcmV0ID0gLUVJTlZBTDsNCj4gPj4gCQlnb3QgY2xrX2Rpc2Fi
bGVfdW5wcmVwYXJlOw0KPiA+Pg0KPiA+Pj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4+PiArCX0N
Cj4gPj4+ICsNCj4gPj4+ICsJaWYgKGNhcHMtPmhhc19mbHhfY3MpIHsNCj4gPj4+ICsJCWRkYXRh
LT5mbGV4Y29tX3NoYXJlZF9iYXNlID0NCj4gPj4gZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVt
YXBfcmVzb3VyY2UocGRldiwgMSwgTlVMTCk7DQo+ID4+PiArCQlpZiAoSVNfRVJSKGRkYXRhLT5m
bGV4Y29tX3NoYXJlZF9iYXNlKSkgew0KPiA+Pj4gKwkJCWNsa19kaXNhYmxlX3VucHJlcGFyZShk
ZGF0YS0+Y2xrKTsNCj4gPj4+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LA0K
PiA+Pj4gKwkJCQkJUFRSX0VSUihkZGF0YS0NCj4gPj4+IGZsZXhjb21fc2hhcmVkX2Jhc2UpLA0K
PiA+Pj4gKwkJCQkJImZhaWxlZCB0byBnZXQgZmxleGNvbSBzaGFyZWQgYmFzZQ0KPiA+PiBhZGRy
ZXNzXG4iKTsNCj4gPj4gCQkJcmV0ID0gZGV2X2Vycl9wcm9iZSguLi4pOw0KPiA+PiAJCQlnb3Rv
IGNsa19kaXNhYmxlX3VucHJlcGFyZTsNCj4gPj4+ICsJCX0NCj4gPj4+ICsNCj4gPj4+ICsJCWVy
ciA9IGF0bWVsX2ZsZXhjb21fbGFuOTY2eF9jc19jb25maWcocGRldik7DQo+ID4+PiArCQlpZiAo
ZXJyKSB7DQo+ID4+PiArCQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRkYXRhLT5jbGspOw0KPiA+
Pj4gKwkJCXJldHVybiBlcnI7DQo+ID4+IAkJCWdvdG8gY2xrX2Rpc2FibGVfdW5wcmVwYXJlOw0K
PiA+Pj4gKwkJfQ0KPiA+Pj4gKwl9DQo+ID4+PiArDQo+ID4+DQo+ID4+IGNsa191bnByZXBhcmU6
DQo+ID4+PiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkZGF0YS0+Y2xrKTsNCj4gPj4gCWlmIChy
ZXQpDQo+ID4+IAkJcmV0dXJuIHJldDsNCj4gPj4+DQo+ID4+PiAgCXJldHVybiBkZXZtX29mX3Bs
YXRmb3JtX3BvcHVsYXRlKCZwZGV2LT5kZXYpOw0KPiA+Pj4gIH0NCj4gPj4+DQo+ID4+PiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBhdG1lbF9mbGV4X2NhcHMgYXRtZWxfZmxleGNvbV9jYXBzID0ge307
DQo+ID4+PiArDQo+ID4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBhdG1lbF9mbGV4X2NhcHMgbGFu
OTY2eF9mbGV4Y29tX2NhcHMgPSB7DQo+ID4+PiArCS5oYXNfZmx4X2NzID0gdHJ1ZSwNCj4gPj4+
ICt9Ow0KPiA+Pj4gKw0KPiA+Pj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0
bWVsX2ZsZXhjb21fb2ZfbWF0Y2hbXSA9IHsNCj4gPj4+IC0JeyAuY29tcGF0aWJsZSA9ICJhdG1l
bCxzYW1hNWQyLWZsZXhjb20iIH0sDQo+ID4+PiArCXsNCj4gPj4+ICsJCS5jb21wYXRpYmxlID0g
ImF0bWVsLHNhbWE1ZDItZmxleGNvbSIsDQo+ID4+PiArCQkuZGF0YSA9ICZhdG1lbF9mbGV4Y29t
X2NhcHMsDQo+ID4+PiArCX0sDQo+ID4+PiArDQo+ID4+PiArCXsNCj4gPj4+ICsJCS5jb21wYXRp
YmxlID0gIm1pY3JvY2hpcCxsYW45NjZ4LWZsZXhjb20iLA0KPiA+Pj4gKwkJLmRhdGEgPSAmbGFu
OTY2eF9mbGV4Y29tX2NhcHMsDQo+ID4+PiArCX0sDQo+ID4+PiArDQo+ID4+PiAgCXsgLyogc2Vu
dGluZWwgKi8gfQ0KPiA+Pj4gIH07DQo+ID4+PiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYXRt
ZWxfZmxleGNvbV9vZl9tYXRjaCk7DQo+ID4NCg0K
