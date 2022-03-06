Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109484CEC01
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 15:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiCFO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 09:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCFO7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 09:59:14 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE7A26544
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 06:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1646578700; x=1647183500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nYA0e7+5crfZfpz5H9oYS7EPe3d5OC4V0CrRZUS1VW0=;
  b=QKDvieFkRkx0fkFGoUnTtFR4gy0yoesBjVHwhRk7inlL3b2co3/rgRWz
   2Trz4iYK0KKb2EJyXOiz8FlT94dh0+ogQCY49bUNDa3DPJSODewnCfCeo
   sx7ZLXUrRwY/GAIx3ZAIJ15ugpWfgCCg+ed+/a7BNdceTujH6BSmdS4HL
   c=;
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 14:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv3Aq33WL/a7Q9OfLo/Wz0ACjNDNHF9Ehu95zepumXYGOUMDxz/mBH5dVdNa220WqNTa349chCCtVc1dnXvJPL2dh9iwHoA8VgDqLt5kdG4mGPyeaoffSMrbVkgz32JIF+BVHe7CjOuK8wbAtQB0L3Lcg80l1+kVCwNy72KWRAf62T91Z531y7/2Qzr8Y7ThNcu+AWsJ4VuLXzd/vRo7T8k1xWA7beirUrgN0yL+bTgyKsV+kfo/KmGazOCX0kHwTrGriZT7TAcEslLhZfqjyZbzFutzcyl+/9qNdnsv/+XXtlQ5gWfwt/s6YO/nS6PW4aIGdNZkTim8DGMV3eP38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYA0e7+5crfZfpz5H9oYS7EPe3d5OC4V0CrRZUS1VW0=;
 b=I8174/0HGbQnU8D7lszyH+ZC3ICPG+Rk1DNlvsPyaUU7sVclKitN//oVeUaLgii4B7L1XM4OKYEWQDilRu1nDueeKbtG15f0dtn4i31AXBtpvDJbW8OtmWu9RhWwhdmQMYtOKDdywTleYhgYrgnoMcDytiuEWyvqrwWitOQOqOlFoLPBdf3Vg/L2cc7Etnxqyraz4F3i2gXJajvUPqyJ7tsrt9i0VTUrNJlg1hTJuZPcJmmbVvJPHsk23OVWaLCIrmyEL3y54zeQShzCso97Yrgmo0ms8K8C8ELAD9Jxrvu+7i2kCqkXAaF8RKJNGUMH4j7+0izZFYmbOkdohgBFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by CH2PR02MB6646.namprd02.prod.outlook.com (2603:10b6:610:a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Sun, 6 Mar
 2022 14:58:12 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%6]) with mapi id 15.20.5038.026; Sun, 6 Mar 2022
 14:58:12 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Sahitya Tummala (QUIC)" <quic_stummala@quicinc.com>,
        "Veerabhadrarao Badiganti (QUIC)" <quic_vbadigan@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
Subject: RE: [PATCH V7] mtd: spi-nor: winbond: add support for W25Q512NW-IM
Thread-Topic: [PATCH V7] mtd: spi-nor: winbond: add support for W25Q512NW-IM
Thread-Index: AQHYHzn9nkd9BTnp2kCou5Nqcg+4i6ykmSWAgA39lhA=
Date:   Sun, 6 Mar 2022 14:58:11 +0000
Message-ID: <SJ0PR02MB84490E47E47519D89DF83395CD079@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1644578661-21821-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <63301527-46ff-b7ee-93dd-12ce9d79008b@microchip.com>
In-Reply-To: <63301527-46ff-b7ee-93dd-12ce9d79008b@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 845a1698-8cad-43ca-7d1d-08d9ff81bc12
x-ms-traffictypediagnostic: CH2PR02MB6646:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR02MB6646B088D8FF2AF2DF7AAC74B1079@CH2PR02MB6646.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bKJeg4X++CINmGaA0/5EhuNsaalhUOz9jm7h8P6RtVhcfgmhTMo5pHJ8HM+uS/BHzZNCBkqUO3/E93PNoUgbvb4T3taFQLu/BDwHJ/vWkUcpQ07oc6pfd6WxIk1KfhYxf4fCCmIRpxT/za507eIvWcABnbDUnZV6+2EOjl5j64Epld2PuRiEMO6QkX7u/sf0bIiIl6I3J9GKSLRx4weqgs/ckf1JyCydEFGjSLwsTO//nvWplXJL383cYTD8JUoqrFfJNfmbEU/N3TL2Fuz5+j1m46WNsdGDk+UQp28coVLhf6dz/vKzpan5dU11MEvpnTc7RtrKcohpAGbFBgdFeC2ox5s6Sj5DnsYKqFGzOe6TzLMJRVcHdxQTyHyhp8158Pe03DrpX55tV2wcI2Mk2uu1cVRMp04/Gdede7GEj5sl7T+OxL+CvF6hxn3e+HS5xDGwiuhVKbQ76n9+SCVQBkaxa00P7GTAvEPDIk4ZY8tRHmmsQ+EJmHlNa5vfxVBaYJZngucF2MG9KFTJ6NJ97uSlRWcVhxQY0qle6KqmXlL6dL2bHeCz8+rMJQr24xF1GKPU4x1pty5JOKoi4i7Pi0tYercna//EeV3aQ2Hlp5vRMwmp+JHH1U4kfYaxZYW5aK9KT0tRS7YlIIBomaUk1xIh7GuDoIH2BTuEjLF0FQjCI3ZGAFL1f8dUplFZ26vPMaOuJEB9owk1IYutpIp4WVMZW5GNQsUwcwG5KVpN7a4uFgYL+n1d/mduZFpbeQ2saaDwByARhKM8ka2N5sABOJpzyM3N4LkuDhyS8UUVjPDGt+HZH5C3NdGK93bagI9Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(53546011)(107886003)(66946007)(33656002)(83380400001)(316002)(38100700002)(54906003)(186003)(26005)(52536014)(110136005)(921005)(122000001)(38070700005)(71200400001)(86362001)(55016003)(2906002)(5660300002)(4326008)(8936002)(966005)(6506007)(7696005)(508600001)(8676002)(76116006)(64756008)(66476007)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU1RRVZ4TzIzWG05bTlpRkY4K1hUMVowQTRPY09wSEgzZVFyZHRRWU9Zb1BE?=
 =?utf-8?B?ZmMvVFJxVGtvUjh3eE1yVTEybkFMd3F0U3U2THA2aWVuY2FPVHl4cUhYcllh?=
 =?utf-8?B?QzN5TDAyQ1NqS0VXbGlSbTJNQkJBa3NvbDN0WjdYckpoTi9RVlNXMFE0K2NG?=
 =?utf-8?B?S2F3dnk5MEhBaUpIdTlCeUJtNVluTkF4TjJmTTdTRXNzcktOejlPdXRlckh1?=
 =?utf-8?B?R1dndlFSaGpiWFJTSFdRUkYxS0d1alhHOFYrK0VMeTllekg5K082cndvL09V?=
 =?utf-8?B?c3NtZnVEYWwxaGNSeHZhWFlCYVI3RnJzZFNOaGZFYVlRdkFHUkV6amtGZTdo?=
 =?utf-8?B?YjNxQzBjUXZpdEZQMEZid01DQkx6TUl2N0tPTzE0ZGQ4bFplRUQrVko4Y0Nr?=
 =?utf-8?B?UC90a0o4ZGd3RW9mcFpWOW1nb1JlalpWZUo0WXVVRFM2N3VKS2M2OW16WURK?=
 =?utf-8?B?SGZOcFhITG43NVJ1SFVZZ3U3dDJxRjNZZVpzK3NYVytlSTU0ZUxBWVExS1h2?=
 =?utf-8?B?RmIxdGpYQ0p6ZmkrK21yY0pjU0dHWXpHdFZ5NElUcGZoVTVodUp0Q2dEMFF5?=
 =?utf-8?B?Yng0U3FuNStGUWFpNE5lNDVkVWFJWEZObVFBOXluN2ZaUmdQd2w1RE91Nllv?=
 =?utf-8?B?cW5aNGMyNlVOWHcvZGtxVmI1YVI4UGkzN250NkxGcjEzRmdjeTNUcVpsSVNo?=
 =?utf-8?B?V0xOS2lxRERJcmFleE52UUhMdWZXcDcwaG1KWjBOaDJ4eXJSeVp4QnRjN0lp?=
 =?utf-8?B?MUoxMW1ENG9pY1BGWmJIVEZSbCtPTEdhMjllUGNLMCtlVXRld3h4aEt6N3ZY?=
 =?utf-8?B?cnZldXJaTGdUaGM1QXhwZG9ick8ycjh6MFY0Rjl2cWN6eE1YNzJEU29IcnpV?=
 =?utf-8?B?VEZXSmVCblVxa2ZqVzY2MmxXakdiL1RYRlV3Qjk5aXdHYlNCbnc1ajFYNlN2?=
 =?utf-8?B?aWs3VWY0QVJ5bUlWNGxBSmliUExHNUU1K281bkYwZGE3MTA3aGhnSmVFZGxI?=
 =?utf-8?B?VEtzYnNBN3NCNmR0YkpScUVXTjIrU3B0L3c3UER0TDdWNlRrSEd6dHZ4UlpU?=
 =?utf-8?B?cTlJL2dzdXJTU0oxTUhPclNKbGRFN1ZNRG16eEFzcmNjcFBYaGtna0xNQ0JT?=
 =?utf-8?B?U3laNHB4aSsyUXdNYVljdlNTWE00WnQzYXVWN1JSTVVISUt5TFlMa1BPcVZn?=
 =?utf-8?B?VTNiZGl5eHNYWWtxZ2FDQ1MzemZZYnNwUnJldUU2MVpkWkJjNjFhUkxuY1hZ?=
 =?utf-8?B?QTdzM3lJOC9zZDIyVkVXRWJJVVJ5eUoxcDdKWk44ZkJJWVJOaHdWQ2ltTzUw?=
 =?utf-8?B?bDJyaENzM3k3M1BYd1dsTVhrQk41Tk9pQzJkNk41bDJnNitXZjMxTTBwTGRm?=
 =?utf-8?B?cDlEcjUwaVVQOGlONDNzeGFOeGcvWUJjSEVPMjluUEcxU1FFTmt5MjQ4MEp2?=
 =?utf-8?B?YmdTdUNqMXRWVS9QUm1hZDlQby94TXhmaGRwR3pHM1ZSeVUzZEZUdGI4dU9J?=
 =?utf-8?B?UVEzZzlndHgxZzVVYmhuWjZUTGoyVXJWcVVFMGVIckExY29zTkF1ZXp4cEZu?=
 =?utf-8?B?blIxTmg5ZGp1ZjFqUjNQVHFnWXZqcjBGWlRDV0NkRHFMQ3F2WG83WTRaMWtS?=
 =?utf-8?B?allRbUMySUFicnVzU0U4cUFYOXpQS2dWeGtpVm9WLytFcEQ1VG9OalJYTnEw?=
 =?utf-8?B?VWJSYzBVTStneUxteW9OQmxJb0xzRW85VVJ6ZVFlVjVBYnBXYUpxcTI1NXZm?=
 =?utf-8?B?ZkNLWGo1cEV4bzByNjdHWEhJV211dFYycWdNNkJTTndxOHNiQzJHWEhkWmd6?=
 =?utf-8?B?enIxQ3BFUFZnQ2xBd0lNY0pXZFk0SlpueWdiSm1lbmg5Q2xad01IcWRIZHh6?=
 =?utf-8?B?bllPMGRiQW5zQlVGODNNT0RISE52NlBzYTg1WHgrdVBWVGxuQVhjS3dhMm9D?=
 =?utf-8?B?ampIOE9EQ0lHZnU4RGFSRnJtNmN2WVN4Uk9heCtSc1BBY1B0eEhEUXlGamVB?=
 =?utf-8?B?WHd5N05wOXZDWEUvWm5hTjU0ZlFocXhTTVg3SFBwdU5TTkpOMDhXOG90QVY3?=
 =?utf-8?B?VDg3VmFtWGp0WU84Y0VnaGhBekh1NWNXVHhzQjBpYkNUaTNNcWhIR3JlTDlC?=
 =?utf-8?B?dE1rem94U3BuM0pqV1dEVnRJR0NSMW5EbThiUjRvTUZsTmVxVUY3WHNhbUdO?=
 =?utf-8?B?Qk56dlRGV0U1NWxkMmtXOGpGV29lanZDQWtnbzdraFZCODhGdlB1d1V0dmo2?=
 =?utf-8?B?bWM2YlYzZnZobDJqNVl5Ti9UODNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845a1698-8cad-43ca-7d1d-08d9ff81bc12
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2022 14:58:11.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6UnG86FsTgVvJa4Uk1zqf5DZzFpXrcujxnJc30+2PPwOm/qCXqv8MOuLrPY/wxt9iJGi90E2rFT/JjqCZN4sUMS/u4Qa+QyJraZEmKoUd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6646
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KUGxlYXNlIGZpbmQgdGhlIGlu
bGluZSBjb21tZW50cy4NCg0KVGhhbmtzLA0KU2FqaWRhDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIDxUdWRvci5BbWJhcnVzQG1p
Y3JvY2hpcC5jb20+IA0KU2VudDogRnJpZGF5LCBGZWJydWFyeSAyNSwgMjAyMiAxMDo0OSBQTQ0K
VG86IFNhamlkYSBCaGFudSAoVGVtcCkgKFFVSUMpIDxxdWljX2Nfc2JoYW51QHF1aWNpbmMuY29t
PjsgZGlhbmRlcnNAY2hyb21pdW0ub3JnOyBtaWNoYWVsQHdhbGxlLmNjOyBwLnlhZGF2QHRpLmNv
bTsgbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsgcmljaGFyZEBub2QuYXQ7IHZpZ25lc2hyQHRp
LmNvbTsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCkNjOiBTYWhpdHlhIFR1bW1hbGEgKFFVSUMpIDxxdWljX3N0dW1tYWxhQHF1aWNp
bmMuY29tPjsgVmVlcmFiaGFkcmFyYW8gQmFkaWdhbnRpIChRVUlDKSA8cXVpY192YmFkaWdhbkBx
dWljaW5jLmNvbT47IFJhbSBQcmFrYXNoIEd1cHRhIChRVUlDKSA8cXVpY19yYW1wcmFrYUBxdWlj
aW5jLmNvbT47IFByYWRlZXAgUHJhZ2FsbGFwYXRpIChRVUlDKSA8cXVpY19wcmFnYWxsYUBxdWlj
aW5jLmNvbT47IFNhcnRoYWsgR2FyZyAoUVVJQykgPHF1aWNfc2FydGdhcmdAcXVpY2luYy5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIIFY3XSBtdGQ6IHNwaS1ub3I6IHdpbmJvbmQ6IGFkZCBzdXBw
b3J0IGZvciBXMjVRNTEyTlctSU0NCg0KSGksDQoNCk9uIDIvMTEvMjIgMTM6MjQsIFNoYWlrIFNh
amlkYSBCaGFudSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyANCj4gdGhlIGNvbnRlbnQgaXMgc2Fm
ZQ0KPiANCj4gQWRkIHN1cHBvcnQgZm9yIHdpbmJvbmQgVzI1UTUxMk5XLUlNIGNoaXAuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBTaGFpayBTYWppZGEgQmhhbnUgPHF1aWNfY19zYmhhbnVAcXVpY2lu
Yy5jb20+DQo+IFJldmlld2VkLWJ5OiBEb3VnIEFuZGVyc29uIDxkaWFuZGVyc0BjaHJvbWl1bS5v
cmc+DQo+IC0tLQ0KPiBsb2NhbGhvc3QgLyAjIGNhdCANCj4gL3N5cy9idXMvcGxhdGZvcm0vZGV2
aWNlcy9zb2NcQDAvODhkYzAwMC5zcGkvc3BpX21hc3Rlci9zcGkxNi8NCj4gc3BpMTYuMC9zcGkt
bm9yL2plZGVjX2lkDQo+IGVmODAyMA0KPiANCj4gbG9jYWxob3N0IC8gIyBjYXQgDQo+IC9zeXMv
YnVzL3BsYXRmb3JtL2RldmljZXMvc29jXEAwLzg4ZGMwMDAuc3BpL3NwaV9tYXN0ZXIvc3BpMTYv
DQo+IHNwaTE2LjAvc3BpLW5vci9tYW51ZmFjdHVyZXINCj4gd2luYm9uZA0KPiANCj4gbG9jYWxo
b3N0IC8gIyBjYXQgDQo+IC9zeXMvYnVzL3BsYXRmb3JtL2RldmljZXMvc29jXEAwLzg4ZGMwMDAu
c3BpL3NwaV9tYXN0ZXIvc3BpMTYvDQo+IHNwaTE2LjAvc3BpLW5vci9wYXJ0bmFtZQ0KPiB3MjVx
NTEybndtDQo+IA0KPiBsb2NhbGhvc3QgLyAjIGhleGR1bXAgDQo+IC9zeXMvYnVzL3BsYXRmb3Jt
L2RldmljZXMvc29jXEAwLzg4ZGMwMDAuc3BpL3NwaV9tYXN0ZXIvc3ANCj4gaTE2L3NwaTE2LjAv
c3BpLW5vci9zZmRwDQo+IDAwMDAwMDAgNDY1MyA1MDQ0IDAxMDYgZmYwMSAwNjAwIDEwMDEgMDA4
MCBmZjAwDQo+IDAwMDAwMTAgMDA4NCAwMjAxIDAwZDAgZmYwMCBmZmZmIGZmZmYgZmZmZiBmZmZm
DQo+IDAwMDAwMjAgNjgwMCA2YzY1IDZmNmMgNzcyMCA3MjZmIDY0NmMgZmZmZiBmZmZmDQo+IDAw
MDAwMzAgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmDQo+ICoNCj4gMDAw
MDA4MCAyMGU1IGZmZmIgZmZmZiAxZmZmIGViNDQgNmIwOCAzYjA4IGJiNDINCj4gMDAwMDA5MCBm
ZmZlIGZmZmYgZmZmZiAwMDAwIGZmZmYgZWI0MCAyMDBjIDUyMGYNCj4gMDAwMDBhMCBkODEwIDAw
MDAgMDIzMyAwMGE2IGU3ODEgZDkxNCA2M2U5IDMzNzYNCj4gMDAwMDBiMCA3NTdhIDc1N2EgYmRm
NyA1Y2Q1IGY3MTkgZmY1ZCA3MGU5IGE1ZjkNCj4gMDAwMDBjMCBmZmZmIGZmZmYgZmZmZiBmZmZm
IGZmZmYgZmZmZiBmZmZmIGZmZmYNCj4gMDAwMDBkMCAwYWZmIGZmZjAgZmYyMSBmZmRjDQo+IDAw
MDAwZDgNCj4gDQo+IGxvY2FsaG9zdCAvICMgbWQ1c3VtIA0KPiAvc3lzL2J1cy9wbGF0Zm9ybS9k
ZXZpY2VzL3NvY1xAMC84OGRjMDAwLnNwaS9zcGlfbWFzdGVyL3NwaQ0KPiAxNi9zcGkxNi4wL3Nw
aS1ub3Ivc2ZkcA0KPiAxMDZkODlkNmMwNDkxMTBiYzk0YzAxNTE3Y2I0Y2UyNCANCj4gL3N5cy9i
dXMvcGxhdGZvcm0vZGV2aWNlcy9zb2NAMC84OGRjMDAwLnNwaS8NCj4gc3BpX21hc3Rlci9zcGkx
Ni9zcGkxNi4wL3NwaS1ub3Ivc2ZkcA0KPiANCj4gQ2hhbmdlcyBzaW5jZSBWMToNCj4gICAgICAg
ICAtIEFkZGVkIHNwYWNlIGJlZm9yZSBuYW1lIG9mIHRoZSBmbGFzaCBwYXJ0IGFzIHN1Z2dlc3Rl
ZCBieSBEb3VnLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSBWMjoNCj4gICAgICAgICAtIFVwZGF0ZWQg
Y2hpcCBuYW1lIGFzIHcyNXE1MTJud20gYXMgc3VnZ2VzdGVkIGJ5IERvdWcuDQo+IA0KPiBDaGFu
Z2VzIHNpbmNlIFYzOg0KPiAgICAgICAgIC0gVXBkYXRlZCBmbGFzaF9pbmZvIGZsYWdzIHBhc3Np
bmcgYWNjb3JkaW5nIHRvIGJlbG93IHBhdGNoLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSBWNDoNCj4g
ICAgICAgICAtIEFkZGVkIE9UUCBzdXBwb3J0IGZvciBTUEkgY2FyZCBhcyBzdWdnZXN0ZWQgYnkg
TWljaGFlbCBXYWxsZS4NCj4gICAgICAgICAtIFVwZGF0ZWQgU0ZEUCBmbGFncyBwYXNzaW5nIGFz
IHN1Z2dlc3RlZCBieSBQcmF0eXVzaCBZYWRhdi4NCj4gDQo+IENoYW5nZXMgc2luY2UgVjU6DQo+
ICAgICAgICAgLSBSZW9yZGVyZWQgZmxhZ3MgcGFzc2luZyBpbmZvIGZvciBzcGkgbm9yIGFzIHN1
Z2dlc3RlZCBieQ0KPiAgICAgICAgICAgTWljaGFlbCBXYWxsZS4NCj4gICAgICAgICAtIEFkZGVk
IFNGRFAgZHVtcCBpbmZvIGluIGNvbW1pdCBhcyBzdWdnZXN0ZWQgYnkgTWljaGFlbCBXYWxsZS4N
Cj4gDQo+IENoYW5nZXMgc2luY2UgVjY6DQo+ICAgICAgICAgLSBVcGRhdGVkIGNvbW1pdCBzdWJq
ZWN0IGFuZCBhZGRlZCBtZDVzdW0gaW4gY29tbWl0IGFzIHN1Z2dlc3RlZA0KPiAgICAgICAgICAg
YnkgTWljaGFlbCBXYWxsZS4NCj4gICAgICAgICAtIFJlb3JkZXJlZCBmbGFncyBwYXNzaW5nIGlu
Zm8gZm9yIHNwaSBub3Igd2hpY2ggaGFzIG1pc3NlZCBpbg0KPiAgICAgICAgICAgVjUgcGF0Y2gg
YXMgc3VnZ2VzdGVkIGJ5IE1pY2hhZWwgV2FsbGUuDQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3Bp
LW5vci93aW5ib25kLmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYyANCj4g
Yi9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYyBpbmRleCA2NzVmMzJjLi42ZmRlMmFjIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYw0KPiArKysgYi9kcml2
ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYw0KPiBAQCAtMTI0LDYgKzEyNCwxMCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGZsYXNoX2luZm8gd2luYm9uZF9wYXJ0c1tdID0gew0KPiAgICAgICAgIHsg
IncyNW01MTJqdiIsIElORk8oMHhlZjcxMTksIDAsIDY0ICogMTAyNCwgMTAyNCkNCj4gICAgICAg
ICAgICAgICAgIE5PX1NGRFBfRkxBR1MoU0VDVF80SyB8IFNQSV9OT1JfUVVBRF9SRUFEIHwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1BJX05PUl9EVUFMX1JFQUQpIH0sDQo+ICsg
ICAgICAgeyAidzI1cTUxMm53bSIsIElORk8oMHhlZjgwMjAsIDAsIDY0ICogMTAyNCwgMTAyNCkN
Cj4gKyAgICAgICAgICAgICAgIFBBUlNFX1NGRFANCj4gKyAgICAgICAgICAgICAgIEZMQUdTKFNQ
SV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9SX0hBU19UQikNCg0KVGhpcyBmbGFzaCBoYXMgM0JQIHN1
cHBvcnQsIHdhcyBsb2NraW5nIHRlc3RlZD8gSSB3b3VsZCBsaWtlIHlvdSB0byBkZXNjcmliZSBp
biB0aGUgY29tbWl0IG1lc3NhZ2UgaG93IHRoZSBmbGFzaCB3YXMgdGVzdGVkLCBhbmQgYWRkIGlu
IHRoZSBjb21tZW50IHNlY3Rpb25zIHByb29mcyBvbiBob3cgaXQgd2FzIHRlc3RlZC4NCg0KaHR0
cHM6Ly93d3cud2luYm9uZC5jb20vcmVzb3VyY2UtZmlsZXMvVzI1UTUxMk5XJTIwUmV2QiUyMDA3
MTkyMDIxLnBkZg0KDQpDaGVlcnMsDQpUYQ0KDQo+IEkgaGF2ZSB0cmllZCB0byB2YWxpZGF0ZSBs
b2NrL3VubG9jayBmZWF0dXJlIG9uIHcyNXE1MTJud20gY2FyZC4gQnV0IGxvb2tzIGxpa2UgdGhl
IGxvY2sgaXMgbm90IHdvcmtpbmcgYXMgZXhwZWN0ZWQsIHNvIHdoZW4gd2UgZG8gbG9jayB0aGUg
d2hvbGUgY2FyZCBhbmQgdHJpZWQgdG8gd3JpdGUsIHdyaXRlIHdhcyBzdWNjZXNzZnVsIHdpdGhv
dXQgYW55IGVycm9ycy4NCiAgIFNpbWlsYXJseSBJIGFsc28gdHJpZWQgdG8gZXJhc2UgbG9jayBw
cm90ZWN0ZWQgYXJlYSwgaXQgd2FzIHN1Y2Nlc3NmdWwgd2l0aG91dCBhbnkgaXNzdWVzLg0KICAg
QmVsb3cgYXJlIHRoZSBleHBlcmltZW50cyBJIHRyaWVkLg0KDQogIGxvY2FsaG9zdCB+ICMgZmxh
c2hfbG9jayAtaSAvZGV2L210ZDANCiAgRGV2aWNlOiAvZGV2L210ZDANCiAgU3RhcnQ6IDANCiAg
TGVuOiAweDQwMDAwMDANCiAgTG9jayBzdGF0dXM6IGxvY2tlZA0KICBSZXR1cm4gY29kZTogMQ0K
ICBsb2NhbGhvc3QgfiAjIG10ZF9kZWJ1ZyBlcmFzZSAvZGV2L210ZDAgMHg0MDAwMDAgNDA5Ng0K
ICBFcmFzZWQgNDA5NiBieXRlcyBmcm9tIGFkZHJlc3MgMHgwMDQwMDAwMCBpbiBmbGFzaA0KICBs
b2NhbGhvc3QgfiAjIG10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRkMCAweDQwMDAwMCA0MDk2IHRlbXAN
CiAgQ29waWVkIDQwOTYgYnl0ZXMgZnJvbSBhZGRyZXNzIDB4MDA0MDAwMDAgaW4gZmxhc2ggdG8g
dGVtcA0KICBsb2NhbGhvc3QgfiAjIG10ZF9kZWJ1ZyB3cml0ZSAvZGV2L210ZDAgMHg0MDAwMDAg
NDA5NiB0ZW1wDQogIENvcGllZCA0MDk2IGJ5dGVzIGZyb20gdGVtcCB0byBhZGRyZXNzIDB4MDA0
MDAwMDAgaW4gZmxhc2gNCiAgbG9jYWxob3N0IH4gIyBmbGFzaF9sb2NrIC11IC9kZXYvbXRkMA0K
ICBsb2NhbGhvc3QgfiAjIGZsYXNoX2xvY2sgLWkgL2Rldi9tdGQwDQogIERldmljZTogL2Rldi9t
dGQwDQogIFN0YXJ0OiAwDQogIExlbjogMHg0MDAwMDAwDQogIExvY2sgc3RhdHVzOiB1bmxvY2tl
ZA0KICBSZXR1cm4gY29kZTogMA0KICBsb2NhbGhvc3QgfiAjIG10ZF9kZWJ1ZyBlcmFzZSAvZGV2
L210ZDAgMHg0MDAwMDAgNDA5Ng0KICBFcmFzZWQgNDA5NiBieXRlcyBmcm9tIGFkZHJlc3MgMHgw
MDQwMDAwMCBpbiBmbGFzaA0KICBsb2NhbGhvc3QgfiAjIG10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRk
MCAweDQwMDAwMCA0MDk2IHRlbXANCiAgQ29waWVkIDQwOTYgYnl0ZXMgZnJvbSBhZGRyZXNzIDB4
MDA0MDAwMDAgaW4gZmxhc2ggdG8gdGVtcA0KICBsb2NhbGhvc3QgfiAjIG10ZF9kZWJ1ZyB3cml0
ZSAvZGV2L210ZDAgMHg0MDAwMDAgNDA5NiB0ZW1wDQogIENvcGllZCA0MDk2IGJ5dGVzIGZyb20g
dGVtcCB0byBhZGRyZXNzIDB4MDA0MDAwMDAgaW4gZmxhc2gNCiAgbG9jYWxob3N0IH4gIw0KDQog
IENvdWxkIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgaXMgdGhpcyBleHBlY3RlZCBiZWhhdmlvciBp
biB0aGlzIHNwZWNpZmljIGNhcmQuDQoNCiAgVGhhbmtzLA0KICBTYWppZGENCg0KPiArICAgICAg
ICAgICAgICAgT1RQX0lORk8oMjU2LCAzLCAweDEwMDAsIDB4MTAwMCkgfSwNCj4gICAgICAgICB7
ICJ3MjVxNTEyanZxIiwgSU5GTygweGVmNDAyMCwgMCwgNjQgKiAxMDI0LCAxMDI0KQ0KPiAgICAg
ICAgICAgICAgICAgTk9fU0ZEUF9GTEFHUyhTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4g
LS0NCj4gUVVBTENPTU0gSU5ESUEsIG9uIGJlaGFsZiBvZiBRdWFsY29tbSBJbm5vdmF0aW9uIENl
bnRlciwgSW5jLiBpcyBhIA0KPiBtZW1iZXIgb2YgQ29kZSBBdXJvcmEgRm9ydW0sIGhvc3RlZCBi
eSBUaGUgTGludXggRm91bmRhdGlvbg0KPiANCg0K
