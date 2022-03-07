Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339A44CF53B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiCGJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiCGJYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:24:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930225675B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646644992; x=1678180992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yeOTOhrt3GC+n/pK68FPs5ok48NI4vS33ZgO9qW7n9Y=;
  b=HMOB+AW7WMJWwr8NxcmTnt5BHGZLmZg+SJ77J0BqZv849vDLj4UblEcx
   EqXKndyxeqngtPHa42d66sDogq80qeidwer11/8kQV8z2YSWi0AzIOdiZ
   JSig+3VYFf9ig5PH8jE3pZ28kmZgIoPN2Mn7QsjKqvaOG2v97CEcg/4EI
   M7gfmuPWUdAnCMt6KfPl4wvH75ZBaJ1lHAF8mOeZl6VrSwHgoclRNgfE7
   gbCwKxR7rG/NyZcQooVfU5uSUy7Kt1Lm5EO+O4kqmGX2PVNgtk9z0Pd1P
   xZITPWmKf0cSaJ4hUe8s4vNYExG6igCz+EEKLNbxutiNoDEnXs1Dg3ywW
   A==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643698800"; 
   d="scan'208";a="151076772"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 02:23:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 02:23:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 7 Mar 2022 02:23:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCaNgI5IPV+nD4KajX3T2uN96hOWFpsBfzGApUHWmPsWb8gHfRFXK1KfhTReMe285kMs1dcEhZj8q61rc293eiLNd+6cx8ijvapwcXXp4kL11zh2sDp0H/7VJj5Wu8SJyl/peW+sxiYwKXXnwHlQNdFncC6K+o9TDnmYCjXk9hi6oPYVjlsoD4uALSaCj59tN1/9TlseQUc8AIcee0IExbyYb5O2nzNCOS95xng17E39ZBjQ1hNet/Rwivg28TMOi7GfxUJoYwxIpVokaZ/gxT/5WWkwASrKzNtkq9rHqUqS+AoN8fmvUJOhcetDygFwVHg1cW9vT/ClNLm3KeKCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeOTOhrt3GC+n/pK68FPs5ok48NI4vS33ZgO9qW7n9Y=;
 b=V7klx/GZEv2SG8W+YtroUwxwMkJvN/nHe7NU1h3BFBH4l6IMb3YpLgCYljgSmaXD00G26Q5TF087rb8IwkKvegO2ngG2SAzllzxNu40G6mvHt4JK96LDuNZ79N5NZH/YVTYQ3/T8o1mInRMnzIsGZ3kUJ62jQ8C3W3JRhy+DdSQeDyvkE4zhEscKErHbu1IvbUt4mSgc1wL3ofvQcbdZaW1XPbZiqZNzEdYrls5WnkBpmcxP4IHtUrdTihyCBdmijTEcQcGxHV6aWefrMFMUWvf5p13ifHzmFIpLh6gwb3CIPgbZQNWpcrCPoi+aozqGGY9pGZhKo80RBZ8VJALTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeOTOhrt3GC+n/pK68FPs5ok48NI4vS33ZgO9qW7n9Y=;
 b=WHW9GnzF4Hj1ZiZXqws5y9eZR1w0DqwjQqmPKi2ZPBDQ0fVXHbU8VRJKlZiFSmV6AAeaJAG5WufH8q5V7s70XWMU76yPmlSd5aujrCjQj/IGkvPOuolY0hELmLGpJnwxTNDT+YzNUHBdtzWYf/pVo31KMAK+xdamfT+0Mm8aRi8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BYAPR11MB2600.namprd11.prod.outlook.com (2603:10b6:a02:c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 09:23:09 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 09:23:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <heiko.thiery@gmail.com>
Subject: Re: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Topic: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Index: AQHYMfKsE2aD0LVQO0KmbZoSG1RT0qyzpgQA
Date:   Mon, 7 Mar 2022 09:23:08 +0000
Message-ID: <92cde38c-d398-44f4-26f8-ef4919f5944e@microchip.com>
References: <20220304185137.3376011-1-michael@walle.cc>
 <7f339d0c-5ca9-261c-a545-d4ebf3bda140@microchip.com>
In-Reply-To: <7f339d0c-5ca9-261c-a545-d4ebf3bda140@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dcae956-5c8c-49fe-d2dd-08da001c1811
x-ms-traffictypediagnostic: BYAPR11MB2600:EE_
x-microsoft-antispam-prvs: <BYAPR11MB2600EE021C70F4E390E18458F0089@BYAPR11MB2600.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aym4fjUUrRV9wEsuXt/r77GJEG5cHEUODOAhERe44XcZQOi8KctQz1mQnxXoNd4aHASYrR8iycLGxjja8JNomFFMKNdJQFlzWEJPmczF31twNOG5HwBZOcME/G5CZ0FhJk7hewQfUBjspErPOAdOu8l+u4tuwh3o8x92A38KXxyDGn23c1EMSrPJPehlgyhUmL1it18dG4qye6zt+vR+pXR852q8vdmUb3mYw+QXIO7svJXxdBdEQwSzbdgHm+K3iCtkyzFJqtT8/foD0XEGzq3uXnYs4PDS3MORSTufjHcRTkkR7DhRucYDM45DMDPffXHyhWKprskPznWPZW9RibmGnwIM8qzxPFyvFe+RNAzBhodYR7CvLpkKJh26/Pp0gcA5eT1n1p4s7ZZ104GaEiqPiRbbBPl9I3Y97r3gSmTxmdnrKx4BVKYp/qdulawtRQfgcE/uq9P8aDXOwBlAm7j9dSIKZHhnxTxLq1M+Ne9A7aQCK6ZNSFEYiBDf3uu1mUdCxJjQDXbOdS+aTI6snpwAcp4vXU5BPXUixjf6ZqeP6iL/MDCCosRmxeKq/JVxIbumTJzH8ta9hM+nIQOiPW6EBU8/hK8O3m7w9NuCOX8rCRl4p7bIxwRioPmVsbvzkSLOXk5wFmSU0TljF1OyNNiXCgLovSD1N/uOFtbyKNqFKtQq5atGBAIk5Z5Ixcc3Es1iqmXcIcFk+cvSyrgQ81iuXJar7AOyI/9Oiq8VH7zQyxHHKLhZBvI2aAtNwa6attjqheFThH7CSd1q1ayIVNek+uFKzNfT7KKTXiCZgBQxRB4NNZgW8jHOEx8AkPE2UwCxKd8nwLZbodHNDTjAQCtz/ejA+AOdGmqQ66Lj+VE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(122000001)(26005)(2616005)(186003)(83380400001)(86362001)(508600001)(31696002)(36756003)(110136005)(66446008)(966005)(66946007)(316002)(66556008)(6512007)(66476007)(76116006)(6486002)(54906003)(64756008)(8676002)(8936002)(31686004)(38100700002)(91956017)(38070700005)(71200400001)(6506007)(53546011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzJ6M1ByclFiaForQUZrK0RwcEJJNFdHYlo0a2ErR21Za0IvY1JwVDdrWkVI?=
 =?utf-8?B?QmRvZG0rQTMwU0JlZGZhUjM2UUU0RElRVFZkQzVvZ0xxTHNDWlRqdG1PcTY4?=
 =?utf-8?B?VGlZSGN2NWJyUW82K2hOSXY5dTJ1SjhGUGVNZklsR1BhazgwVVl0R3hxRmRv?=
 =?utf-8?B?WkIzRkd3L3FUemVKOHFrM1V1VWJsaDRkZXdldGtrVEhObXpOOUFMaDB0VU13?=
 =?utf-8?B?NHJ0SzRocGJyWTdVU0tFREM3em5oQW1qUUFMekJxVVlCcnlWY2lmcFhvWjNw?=
 =?utf-8?B?U3I1TnIxbWUyL1FiN0FBZG1RL01MSjNkNVUzaUcvVWZ6dmpicmhFT0Y3TXRw?=
 =?utf-8?B?d2xJckgyZnVjZWFTQ202ZTBqQlNJamdROFZGN3hjOGF0bHhPTnhzNmNlNUR2?=
 =?utf-8?B?N1F0MWFXeEhBTDNDcFk0eituVnJmTjc2ejROeEcraFpIOFdybXhlbTd1ZjhX?=
 =?utf-8?B?UFNPZWFxa3I3N2MwVGovdWFzSVczSWd0SzA3ZHZ4a21RTDRUTDN0Z3lrOG5L?=
 =?utf-8?B?ZTdZZWl3T3F1STNNaTBVNDl1QWFQOXp4UVZSY0t1VmlyOUQwbVljYmJscEFx?=
 =?utf-8?B?b2tFTExkd2RsSHBYZGtLRTRwdW1HMEEwTXlSbTM0UjJBYUg1NWdFS3gzcitx?=
 =?utf-8?B?ZHVkdjdtZnhKM0k4UW13YnJsOSt6ZGdzcXQwUGd6b3ViczlEbE04cnUwc2Rh?=
 =?utf-8?B?N2pXYzN3RzIwMjVyanEwYy8wL0dtQi9qc2ZnaDB6WEY2S1E4V1VhKy9sakFy?=
 =?utf-8?B?TC9jTnduditYYlQvMm5acWxHK2RZMWNObUdsLzhwQjJuVHV4YlJQOTVsVzZu?=
 =?utf-8?B?bjBEVDNhUGsrYTlkbCtNQXNUaDEwU2s4SFI3cHJScnhVUkVHZFlQbDBPck94?=
 =?utf-8?B?SE9xYzVISGxDUllzK3Y5K0ttQnh2cFRZekVFYTJ4N25JdDBya01SWjlQQ3Jk?=
 =?utf-8?B?K2crNHdoVXBlLzd2WWxrMVpCbFQrd2pxdkprdTVVck9IcWJNcE04d0Z2UXRp?=
 =?utf-8?B?S3orTGMyMkllU2toc0ZkNzU0Q0o4Sm12S0NwMXQ1YUNuZVBaWkNTWnB5cU5B?=
 =?utf-8?B?Z2piT3JXVjFzb1ZqUVZnTEpmUGpycEEvNEJtR3lSblpBbW5qWERVZzQ1bTN0?=
 =?utf-8?B?VnF4S0ZQMFZnYzgwbFZXbDVMNlV2bTcwRURIYWR2MDZ4U1pPUVZxZXEwbCs2?=
 =?utf-8?B?enRvRHoySVdsREdFSWN0WkVIY1FpUko2ZmxLMFlKOUJGUjljMEVHNy8yVmc4?=
 =?utf-8?B?bG5DZ3F5c1VvaVBiTEZYWVgxTytNWDc0NlNBRzZWRDFwYmpaNXFJbjI3bXFD?=
 =?utf-8?B?NTlBNGxwSUVtTUVaWE1tOWVkZk9CYmlyTDNFR0lERGQxNlgyQXJPK013b0N5?=
 =?utf-8?B?SzZFa2RGNGhVRHpSQXRhK3g1RzQ0eHlwUFBxdjlxYk9aaXJncWJsZjc2Q2Ri?=
 =?utf-8?B?WExhQTBSeFRHbXd4WHljV2xBTXFpWXJDV25NSk5iZWZiRmVOUHpjYnJrdnFS?=
 =?utf-8?B?SFZuSmthZ2ppVEVTQmsrZXFqV1dhdzdpamN1U1hLREJhZnNwN2JYTW9PZ2wx?=
 =?utf-8?B?U0ZMUVpiU2IwL2RFbmRMSjdTV3kzY21jMmdIeXl0NHZSUHY3U3F3anVnS0lk?=
 =?utf-8?B?Tjhmd1JDcE5xN1hVaUxMWHpNdVFwdHMraS9FZFNPVHNNNURZS2dDdUVQNDNK?=
 =?utf-8?B?QUJrZTdFM0JPd0hXMkFVWHhLK2hGYlUrdDU1N3NQd2JrSEpIYk1DazEya3hs?=
 =?utf-8?B?ZW8wTTlZRTNuVkVsYUdQSXh1RkFnNzEveU80cTk1N1VDMm5TeHdKSHZpSGpy?=
 =?utf-8?B?aENPWHNkU1Q3SlZmWjR5SjVxaUx0b3hmVitYRkwvYkNHZEhsMnl6ZTN0U3JY?=
 =?utf-8?B?bDNPdDNhbGZZYlJkQXl1YXZIWDJTS2djclNqTVNaMTd2QmhkczVmRCtGbnpG?=
 =?utf-8?B?VWxWVkpCTjJFUkVpVnhlSmloRDlDelY0bndpNCtsZS9VOUVLVXJEWFR2b1FT?=
 =?utf-8?B?dlNrejBQNU4zQTBCMDYrRjREbzJHb2owYlJJZUJjT2J6TVF5YjY2UURRSm1O?=
 =?utf-8?B?T0xqU0pTaXN3WXBZb2RnMzR1WmxucU5LcEs0T1VWdnpSZERQWDIxUnQ4OWt1?=
 =?utf-8?B?b0MvTXJXaUwvR0xwZFhraUdXdWpvdEFrQVV5YkM2T1pmc045SmNVNldCNGJH?=
 =?utf-8?B?MUZBaTF2TVZxOXdPblpvdEpZVldhUldSSks3NTl3WXN3NDRjTnhUdTFjdW5Y?=
 =?utf-8?B?bmlZUUpYMHV3QlhOYnRrRHlnWjBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95E09864A930114FAA26CD545BD3AA40@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcae956-5c8c-49fe-d2dd-08da001c1811
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 09:23:08.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNLE/EbynxHa05WPy1WipQVyRlpGOfpDNIMLmmAX3fuvk4pFuX9M/3AATdH1M+AEwZUkqfU2/yUlNzN7FtPV+tTR8hxo+f1W0427bJIwHXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy83LzIyIDA5OjEyLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMy80LzIyIDIwOjUxLCBN
aWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+Pg0KPj4gV2hpbGUgdGhlIGZpcnN0IHZlcnNpb24gb2YgSkVTRDIxNiBzcGVjaWZ5IHRoZSBv
cGNvZGUgZm9yIDQgYml0IEkvTw0KPj4gYWNjZXNzZXMsIGl0IGxhY2tzIGluZm9ybWF0aW9uIG9u
IGhvdyB0byBhY3R1YWxseSBlbmFibGUgdGhpcyBtb2RlLg0KPj4NCj4+IEZvciBub3csIHRoZSBv
bmUgc2V0IGluIHNwaV9ub3JfaW5pdF9kZWZhdWx0X3BhcmFtcygpIHdpbGwgYmUgdXNlZC4NCj4+
IEJ1dCB0aGlzIG9uZSBpcyBsaWtlbHkgd3JvbmcgZm9yIHNvbWUgZmxhc2hlcywgaW4gcGFydGlj
dWxhciB0aGUNCj4+IE1hY3Jvbml4IE1YMjVMMTI4MzVGLiBUaHVzIHdlIG5lZWQgdG8gY2xlYXIg
dGhlIGVuYWJsZSBtZXRob2Qgd2hlbg0KPj4gcGFyc2luZyB0aGUgU0ZEUC4gRmxhc2hlcyB3aXRo
IHN1Y2ggYW4gU0ZEUCByZXZpc2lvbiB3aWxsIGhhdmUgdG8gdXNlIGENCj4+IGZsYXNoIChhbmQg
U0ZEUCByZXZpc2lvbikgc3BlY2lmaWMgZml4dXAuDQo+Pg0KPj4gVGhpcyBtaWdodCBicmVhayBx
dWFkIEkvTyBmb3Igc29tZSBmbGFzaGVzIHdoaWNoIHJlbGllZCBvbiB0aGUNCj4+IHNwaV9ub3Jf
c3IyX2JpdDFfcXVhZF9lbmFibGUoKSB0aGF0IHdhcyBmb3JtZXJseSBzZXQuIElmIHlvdXIgYmlz
ZWN0DQo+PiB0dXJucyB1cCB0aGlzIGNvbW1pdCwgeW91J2xsIHByb2JhYmx5IGhhdmUgdG8gc2V0
IHRoZSBwcm9wZXINCj4+IHF1YWRfZW5hYmxlIG1ldGhvZCBpbiBhIHBvc3RfYmZwdCgpIGZpeHVw
IGZvciB5b3VyIGZsYXNoLg0KPj4NCj4gDQo+IFJpZ2h0LCBJIG1lYW50IGFkZGluZyBhIHBhcmFn
cmFwaCBzdWNoIGFzIHRoZSBvbmUgZnJvbSBhYm92ZS4NCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBN
aWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPj4gVGVzdGVkLWJ5OiBIZWlrbyBUaGll
cnkgPGhlaWtvLnRoaWVyeUBnbWFpbC5jb20+DQo+PiAtLS0NCj4+IGNoYW5nZXMgc2luY2UgUkZD
Og0KPj4gIC0gcmV3b3JkZWQgY29tbWl0IG1lc3NhZ2UNCj4+ICAtIGFkZGVkIGNvbW1lbnQgYWJv
dXQgcG9zdF9iZnB0IGhvb2sNCj4+DQo+PiBUdWRvciwgSSdtIG5vdCBzdXJlIHdoYXQgeW91IG1l
YW50IHdpdGgNCj4+ICAgTWF5YmUgeW91IGNhbiB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIGFu
ZCBleHBsYWluIHdoeSB3b3VsZCBzb21lDQo+PiAgIGZsYXNoZXMgZmFpbCB0byBlbmFibGUgcXVh
ZCBtb2RlLCBzaW1pbGFyIHRvIHdoYXQgSSBkaWQuDQo+Pg0KPj4gSXQgZG9lc24ndCB3b3JrIGJl
Y2F1c2UgdGhlIHdyb25nIG1ldGhvZCBpcyBjaG9zZW4/IDspDQo+Pg0KPj4gIGRyaXZlcnMvbXRk
L3NwaS1ub3Ivc2ZkcC5jIHwgMTEgKysrKysrKysrKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL3NmZHAuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+PiBpbmRl
eCBhNTIxMTU0M2QzMGQuLjZiYmE5YjYwMTg0NiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivc2ZkcC5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYw0KPj4g
QEAgLTU0OSw2ICs1NDksMTYgQEAgc3RhdGljIGludCBzcGlfbm9yX3BhcnNlX2JmcHQoc3RydWN0
IHNwaV9ub3IgKm5vciwNCj4+ICAgICAgICAgbWFwLT51bmlmb3JtX2VyYXNlX3R5cGUgPSBtYXAt
PnVuaWZvcm1fcmVnaW9uLm9mZnNldCAmDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgU05PUl9FUkFTRV9UWVBFX01BU0s7DQo+Pg0KPj4gKyAgICAgICAvKg0KPj4gKyAgICAg
ICAgKiBUaGUgZmlyc3QgSkVTRDIxNiByZXZpc2lvbiBkb2Vzbid0IHNwZWNpZnkgYSBtZXRob2Qg
dG8gZW5hYmxlDQo+PiArICAgICAgICAqIHF1YWQgbW9kZS4gc3BpX25vcl9pbml0X2RlZmF1bHRf
cGFyYW1zKCkgd2lsbCBzZXQgYSBsZWdhY3kNCj4+ICsgICAgICAgICogZGVmYXVsdCBtZXRob2Qg
dG8gZW5hYmxlIHF1YWQgbW9kZS4gV2UgaGF2ZSB0byBkaXNhYmxlIGl0DQo+PiArICAgICAgICAq
IGFnYWluLg0KPj4gKyAgICAgICAgKiBGbGFzaGVzIHdpdGggdGhpcyBKRVNEMjE2IHJldmlzaW9u
IG5lZWQgdG8gc2V0IHRoZSBxdWFkX2VuYWJsZQ0KPj4gKyAgICAgICAgKiBtZXRob2QgaW4gdGhl
aXIgcG9zdF9iZnB0KCkgZml4dXAgaWYgdGhleSB3YW50IHRvIHVzZSBxdWFkIEkvTy4NCj4+ICsg
ICAgICAgICovDQo+IA0KPiBHcmVhdC4gTG9va3MgZ29vZCB0byBtZS4gSSdsbCBjaGFuZ2UgdGhl
IHN1YmplY3QgdG8gIm10ZDogc3BpLW5vcjogc2ZkcDoiDQo+IHdoZW4gYXBwbHlpbmcuDQoNCkFz
IHdlIHRhbGtlZCBvbiB0aGUgbWVldGluZywgd2UgY2FuIGluc3RlYWQgbW92ZSB0aGUgZGVmYXVs
dCBxdWFkIG1vZGUgaW5pdA0KdG8gdGhlIGRlcHJlY2F0ZWQgd2F5IG9mIGluaXRpYWxpemluZyB0
aGUgcGFyYW1zLCBvci9hbmQgdG8gd2hlcmUgU0tJUF9TRkRQDQppcyB1c2VkLiBUaGlzIHdheSB5
b3UnbGwgbm8gbG9uZ2VyIG5lZWQgdG8gY2xlYXIgaXQgaGVyZS4NCg0KPiANCj4gQ2hlZXJzLA0K
PiB0YQ0KPj4gKyAgICAgICBwYXJhbXMtPnF1YWRfZW5hYmxlID0gTlVMTDsNCj4+ICsNCj4+ICAg
ICAgICAgLyogU3RvcCBoZXJlIGlmIG5vdCBKRVNEMjE2IHJldiBBIG9yIGxhdGVyLiAqLw0KPj4g
ICAgICAgICBpZiAoYmZwdF9oZWFkZXItPmxlbmd0aCA9PSBCRlBUX0RXT1JEX01BWF9KRVNEMjE2
KQ0KPj4gICAgICAgICAgICAgICAgIHJldHVybiBzcGlfbm9yX3Bvc3RfYmZwdF9maXh1cHMobm9y
LCBiZnB0X2hlYWRlciwgJmJmcHQpOw0KPj4gQEAgLTU2Miw3ICs1NzIsNiBAQCBzdGF0aWMgaW50
IHNwaV9ub3JfcGFyc2VfYmZwdChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4gICAgICAgICAvKiBR
dWFkIEVuYWJsZSBSZXF1aXJlbWVudHMuICovDQo+PiAgICAgICAgIHN3aXRjaCAoYmZwdC5kd29y
ZHNbQkZQVF9EV09SRCgxNSldICYgQkZQVF9EV09SRDE1X1FFUl9NQVNLKSB7DQo+PiAgICAgICAg
IGNhc2UgQkZQVF9EV09SRDE1X1FFUl9OT05FOg0KPj4gLSAgICAgICAgICAgICAgIHBhcmFtcy0+
cXVhZF9lbmFibGUgPSBOVUxMOw0KPj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4NCj4+ICAg
ICAgICAgY2FzZSBCRlBUX0RXT1JEMTVfUUVSX1NSMl9CSVQxX0JVR0dZOg0KPj4gLS0NCj4+IDIu
MzAuMg0KPj4NCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBMaW51eCBNVEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QNCj4gaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQvDQoNCg==
