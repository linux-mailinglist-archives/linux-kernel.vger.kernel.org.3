Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5016A5335E9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 05:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbiEYDww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 23:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiEYDwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 23:52:50 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48AD5BD0F;
        Tue, 24 May 2022 20:52:47 -0700 (PDT)
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 56ADD45ED6;
        Wed, 25 May 2022 03:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1653450767; bh=TMN0bTZhglN4fJDF1kcCWjwF3iA+KcOIw1Vp8pv1zKw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LhRMrj+h0dUHFkkp2UUFRsxHz9YE/kiJsACSoQzfGLsgcqPu/MaeweHFdnOWtUpMO
         u8ZJ22x6dR43gCMU9lluENG6TQaaSRFsHVyMSHjvoR9N9R6ffKImbGxI5PuGnaTdrk
         y/+cnWcuEhvx2ti8MpSugiKeJ5ZRU2NBlciPlshBlYiYZufS4QoA8B9St1OhB67u7u
         5IHnxJSh7KlKJl+uGPtjtJ1IiVCVvxEzlR+qYSmYUmqG/ifSDCZsyQ9MoZZeALFCym
         pPdTwF2dQCVFmpd5s5FTd1EaliizH3wSDPQ+Q3ypfFCkKUFQ4XrF6j6LNLAPfAu5O7
         wFs4sOgo1h8hA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5C31BA008A;
        Wed, 25 May 2022 03:52:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6ECEB40067;
        Wed, 25 May 2022 03:52:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="CRGHtWvi";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPog08gJqHpJBqia/6ONbNwI6dO+G0RjvvZromkEiY2LOlRec2wMEcFtmJwPsSye2IGXMPhH4Sl9pKH+8kf5ATm1vIJM08xRD1gUoVfAmOcTkmTO+UcmNsPp1e1B1u8sU5sOwNBfx/cwbY45Z3MTZVcmX9QY8BhiNFI8QUHeVRnY3T2Aez35GdfUOasZN5sifEdg8hhsvzOWKOgvECKV6ETJXUU0XiYVIRRz7ft7tar6i7cAD9l/iwZn0CnjdcnK9fFQsn1vVTaiOX6Iq8MfWrF+NBQV32KhLE79eQKGUmoASHnerlq2sdB9X6P/xiqzABdcNt71urqE8AJ+3CCGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMN0bTZhglN4fJDF1kcCWjwF3iA+KcOIw1Vp8pv1zKw=;
 b=N0G7o7+7I9TUcFTNpsGz2+RztYbyCCo6DJlpUUiE5vymw7S5GGP8QOQndwndvKtF75lfgPzG/6T7+yS9D5b/Vh2KNAuZWLnrVDw/1WJWR3swF8S5MaHvY1tVOYF/T+sgHmXAY3EyP3hF6J+L+OK0YV2QRVt+A1flyxalN+tDmFxKzM1i30CjR2WgHrTK+c8gKeIvaDG+rYTswK0baNWm3oTmiOfCx2jOcHvuxs7fFebqfmRsyTm2ONAP2wXTy1nUCkyKwqqysdz23tjBTBAL4htuNYd71MPGIlwltBQNVbxL3gS5dMYuMWZzTxGNjTydRthg3m0s9+rW0GJpnNC+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMN0bTZhglN4fJDF1kcCWjwF3iA+KcOIw1Vp8pv1zKw=;
 b=CRGHtWvipwfA1x2mhnY4ykK3U1jWreBWLHaO3NoUDNIJ+wj8Bi3sn0ElSVfGUSEl/tkA/oziOelpJUuQaKvDasqpoY7Gh6mUyBx+sRC9vMS1zpP2wh+3rzOg9MlXqVd9TQ4x5Qa3SwASNrIHsUSAGObOA8D4aUi6ZAkp0UBN+vA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 03:52:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::91c7:7e6b:d663:a349]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::91c7:7e6b:d663:a349%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 03:52:40 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Mayank Rana <quic_mrana@quicinc.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: Fix ep0 handling when getting reset while
 doing control transfer
Thread-Topic: [PATCH] usb: dwc3: Fix ep0 handling when getting reset while
 doing control transfer
Thread-Index: AQHYX+5Z58SB+IQlLUOvFfRQIo8Rqa0u4EMAgAA1oYA=
Date:   Wed, 25 May 2022 03:52:40 +0000
Message-ID: <ba6285cb-f9ff-8047-ad53-1f4534517b66@synopsys.com>
References: <1651693001-29891-1-git-send-email-quic_mrana@quicinc.com>
 <ac4a59de-2eae-cab3-4b28-b89582978648@synopsys.com>
In-Reply-To: <ac4a59de-2eae-cab3-4b28-b89582978648@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7db826dc-0572-4ff1-75b7-08da3e02040d
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5324E40E8AECFC43A176D364AAD69@BN9PR12MB5324.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SPxxGuicaurQyTbD3NZ73ycr9IY4P+5VqVXPG6P6rPCIA3ogx4Aw5MidHx7WKHYs5+P9uoHi1AJGzcT2Lyht2uO/smDFZ+qNIFkh35ULogHOgFjghzQH8g937nNJtMg6hfyJn4pcm04opXELJI3DXI2T5SdhgPbDZmSiBPUHXlaSnC89cj7f4wvdpKIFIoEKay2gEH5TalGd57GXe0z1B/Y3KVfvpPifunx9aN5drJL6fW+uEuJJLv+2Li0Pm/UT0wNpi9PbRnZCxVqDkl5qe5ZR3qyqZcxaTRXiZjCbqexygeekOmmQ0lTPsvniLGN4dW+XjNLGMqh+B7Y8ZIKvzoAzEhGzjG3NwJZ1NTHUzhxMZM9dKChjv6tNjQPwsmHbA6jjcQ4fDOUbRVdgSs0ijZBzNPjT9d4ctKXO+v3oLIVlDFPiuBYbaNBimBp35d2BRwl9xAKdYropQGP6kOr/Aj3lMDjc8w4MDQ5DzPACtgkeiKx5hWSEjhTR5rK+tPXFaw8C1L3cRdHqEVgtEPqOYIzrjozV4o2/PFpb2kRTxczGa/fVwE/TkCJsSuYlugV+4akQ80HRsNoeJ8axf29wrxk9Gp4nWsUd5yq7MDBMPTMdibKRzcZWzFUpporJQcbCR3JXB1Z17qAX6Qe1uquwsiTCDB5CVS6/NhJydBysx9k/Ge9nH4UDE+hyI6qpDLfKlNKMLZmFB7kc+54bhsnnn/gkRReviHhfuVLm5GaykcPOGZjMMRukxWAWjxbqILPVQZXYGJ5Zp1NfvlZlsDgKWctFCtGlGhRyzlXcYq72QcU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(2616005)(186003)(71200400001)(4326008)(38070700005)(54906003)(6506007)(8676002)(110136005)(8936002)(5660300002)(26005)(31686004)(6512007)(316002)(508600001)(83380400001)(31696002)(38100700002)(122000001)(86362001)(64756008)(36756003)(66946007)(76116006)(66476007)(66556008)(66446008)(2906002)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3FKenZiLytMSUwxZEVuTk02WDM0dTVoblpTaVprMlljY21CZXRQYmJ1MHlK?=
 =?utf-8?B?cEVWU2JLamkzT0RaTUYreHRVZURJMUV3ME83Mk0zY1NKYXhWMVFOMUZqM2Vu?=
 =?utf-8?B?MytOT1FTL1NYT0lwbHdxeSsvSzhCTTYrWDRUYTdJdkdFeHRtcVpGU1h6L1NV?=
 =?utf-8?B?cC9HaEpLZ1RHSThYc25pR2dLUjdBWnBCdmt2U2s2ZzhybG1wM0MvaUMxa1hB?=
 =?utf-8?B?SDlVMkc0cnM1TWc3ZzNzd3lCRjh4ei9QZlJVUmo0VjBxRjlmRWZRbG1BeFZ5?=
 =?utf-8?B?TWJSUGlXN05wZVRwUUttOS9WTXpObmRZeDF6UXBDcDIrKzlSdVNUd3RLQ3V0?=
 =?utf-8?B?WmI1Yjc4NHk4N0lOUmd1THhEMTRBWEZYa1lZeVZ0QU9ycmNiSXQvOFR1NUpY?=
 =?utf-8?B?N1ZxZjVISXVaeHBXQlcyVm9OYmFQRHpIM3JCU29FQktRWi80MTRJL3lzeU5q?=
 =?utf-8?B?TUVJdmNZdVhwMHNQYkhHUEJQMDJkUjVOMzk2anJDbWpadGFwVUNKMThhMm0y?=
 =?utf-8?B?SFkrZGpHQzQycjc3ZCtLQ0hNcVhBQk8rM0xVbVBGVlBBdE5Zam1Rbm1LRjJK?=
 =?utf-8?B?YTJWQ0lQT0gyczlsazlHNzZHd3VyU2NqSGc4dGpNS0RKUTlkakZ6KzczMFlS?=
 =?utf-8?B?bXl3UmhuSHhqUVdQczVtWm00VUEvMGVYUityMml6Z05ydFZCa1ZzNnVGSXNC?=
 =?utf-8?B?R2dKZFlGUTdTUWNqWmZMTzFocndBdkh0UzVqQ3pBTktNM2N0MlJWczJLaVlW?=
 =?utf-8?B?K0E5M0FMZjNLcXNWQS9zVmNINnRNM2N1MXgvblRwWWh4THRJajNORmk4enF4?=
 =?utf-8?B?T0xyenRYUWNGK3R3RkxQejk4VFJUamlkRFhEcGtmdmZQMXorMWxzdUFFN2FJ?=
 =?utf-8?B?UkxWSEw4V0hqTG9ydlc0YXZXd01TeGVoaUVhTzRVZGxHNjhyQzcvS1BtOUhR?=
 =?utf-8?B?RFdZRnBUYytmdDlBcmlwWTE3bTFISVIyWmNqV00zYldoQmpDaTVpN0M3b1NN?=
 =?utf-8?B?TFFnc2U3L2FUb2V4MzBHN3MzWmo1NFFwbng0QUFwbmR5dFpGZFVNYm15Y0Ey?=
 =?utf-8?B?dDFXOXNhSlJvVnBlODFCakYwbEV5VUpnUERaQ0VRcVVPb2hodHpjbHhYTHlM?=
 =?utf-8?B?UDNSUXVwb2ZsMituQ0Z6Q3lNWlYwclhrNExDcnFzOW5IVlFmKzBhWGNUdEtT?=
 =?utf-8?B?c3hCUzlPY3VRc09odWcrWHBrclpWakdrV2U0YTU4ZzNNbVB1eXNMVlBqa2Fz?=
 =?utf-8?B?OVppVXROY3U5TzAxbGJTQm1ZU01kMWd3anJDZm5COGp3TTVJdVp6dDBuQTI5?=
 =?utf-8?B?dVcxakZmYkx1cFBFWXpHM0J2SjZNbHhQSU56MjhvVEJmZktkelZwaWpod2VJ?=
 =?utf-8?B?ZmdnN3ZZVkVzZ1FlSndUU0FiQjIyUDVkOHJCQVdubmEvVTFuT1hvc2w4a1N0?=
 =?utf-8?B?UkZqZkU3dlM5OFMvamcxV2xlLzBmSnZ2cTlETmg1VFdqY2M0MWJjU3pKaENE?=
 =?utf-8?B?ZzZQUU1PY3FDYlEyeTIzQ3lEc2Y5Qk4rbjFuYVRvR1VaemJGSk9xMThnZGJQ?=
 =?utf-8?B?aW1BcHAxSlpXYkxuanZBYWtHb3U3N1cxY0VCcHY4V3F6dGpWckdqbWlTSmhZ?=
 =?utf-8?B?MWc0ZjRDSU5EOUNqNGxBUzArbVVaY0Fxc09iVDJiREdmMk1abjVpdExSM0Fm?=
 =?utf-8?B?L2w1NDg4c0kyNGd4cnpvSGE3NlU5UVAreDZjbmNVYytibENGc1ZMNi9zTExZ?=
 =?utf-8?B?d0hZQkh6WmFkaGJTVUxTOVhzMTJlWGJVNHIzTWF3dW91RkM1RWdLc1FySDcw?=
 =?utf-8?B?K202Vm5yZVRTTUZLb1k1MTRkU2h6M2tPaFF6Z210d0JFSVpRVjlIVDk4bnlX?=
 =?utf-8?B?QjhkaW8wdHJQK2k0dk1vZkZBRk85ODRWci9UUTJ1clVmNHBkL2x6amNKMVVQ?=
 =?utf-8?B?YjUxMjdhS1Y5RG5jTXBqUlV5ZUdyTVVGNjNsZlBsQzRxRmkyZXBaM1RJaDZU?=
 =?utf-8?B?eE82NkptZWs3MG5nV053eTZhUy85ajVxaUh2WGpVSHM3RGs4UGtrT1hONFFG?=
 =?utf-8?B?d2dHRGF2MGc4dmd0ODVXQmhLSFIwRnlYSVk3SFpnV0FZc01VUStPejV0TjQ0?=
 =?utf-8?B?MG1VTEtOeEFMWnJpVU5PbjZYVExJb0VIYVlJMmtLSXR5UHc2UUk1VjNyK2xB?=
 =?utf-8?B?TTVGTDdEcmVWOG16TmVPKzE4Q2lUUEZPNjhEdHBGSkF5cHRQRWpLN1pRV3JP?=
 =?utf-8?B?bEZOMlVLaEdXOElWc2U5eC81Mko5UG1YVzlLTnRtSFNuOVY0cjVBTmhIQ0Vh?=
 =?utf-8?B?dW9BWmY1cURkQllMU0tucG1TYituTlNvTXN4czdyenAwVDZ1YlUzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48557DE79D31174EBED02BADCE3F86D8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db826dc-0572-4ff1-75b7-08da3e02040d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 03:52:40.4569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: To0QQF0www4W/2moJwbNBB2VLG7sActRTe1S6OmWqA1pRQZIYc+Qbln5qwKOznxbXcRpil2htk2OU6GK3Haipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5324
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KDQo+IE1heWFuayBSYW5hIHdyb3RlOg0KPj4gQEAgLTM3NjYs
NiArMzc2OCwyNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9yZXNldF9pbnRlcnJ1cHQoc3Ry
dWN0IGR3YzMgKmR3YykNCj4+ICAJfQ0KPj4gIA0KPj4gIAlkd2MzX3Jlc2V0X2dhZGdldChkd2Mp
Ow0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBGcm9tIFNOUFMgZGF0YWJvb2sgc2VjdGlvbiA4LjEu
MiwgdGhlIEVQMCBzaG91bGQgYmUgaW4gc2V0dXANCj4+ICsJICogcGhhc2UuIFNvIGVuc3VyZSB0
aGF0IEVQMCBpcyBpbiBzZXR1cCBwaGFzZSBieSBpc3N1aW5nIGEgc3RhbGwNCj4+ICsJICogYW5k
IHJlc3RhcnQgaWYgRVAwIGlzIG5vdCBpbiBzZXR1cCBwaGFzZS4NCj4+ICsJICovDQo+IA0KPiBX
ZSBzaG91bGQgbm90IGlzc3VlIEVuZCBUcmFuc2ZlciB0byBjb250cm9sIGVuZHBvaW50IHVubGVz
cyBpdCdzIGVycm9yDQo+IGNhc2Ugc3VjaCBhcyBpbnZhbGlkIGRpcmVjdGlvbi4gVGhlIGRhdGFi
b29rIGFsc28gc3BlY2lmeSB1bmRlciBzZWN0aW9uDQo+IFVTQiByZXNldCBpbml0aWFsaXphdGlv
biB0byBub3Qgc2VuZCBFbmQgVHJhbnNmZXIgdG8gY29udHJvbCBlbmRwb2ludC4NCj4gDQo+PiAr
CWlmIChkd2MtPmVwMHN0YXRlICE9IEVQMF9TRVRVUF9QSEFTRSkgew0KPj4gKwkJdW5zaWduZWQg
aW50CWRpcjsNCj4+ICsNCj4+ICsJCWRpciA9ICEhZHdjLT5lcDBfZXhwZWN0X2luOw0KPj4gKwkJ
aWYgKGR3Yy0+ZXAwc3RhdGUgPT0gRVAwX0RBVEFfUEhBU0UpDQo+PiArCQkJZHdjM19lcDBfZW5k
X2NvbnRyb2xfZGF0YShkd2MsIGR3Yy0+ZXBzW2Rpcl0pOw0KPj4gKwkJZWxzZQ0KPj4gKwkJCWR3
YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoZHdjLCBkd2MtPmVwc1shZGlyXSk7DQoNCk9uIHNlY29u
ZCB0aG91Z2h0LCBpdCBzZWVtcyBjbGVhbmVyIHRvIGRvIHRoaXMgdGhvdWdoIHRoZSBiZWhhdmlv
ciBpcw0KdW5kZWZpbmVkLg0KDQpEbyB5b3UgaGF2ZSB0aGUgZHJpdmVyIHRyYWNlcG9pbnQgbG9n
IGNhcHR1cmUgb2YgdGhpcyBzY2VuYXJpbz8gSXQnZCBiZQ0KZ3JlYXQgaWYgSSBjYW4gYWxzbyBy
ZXZpZXcgaXQuDQoNClRoYW5rcyENClRoaW5oDQo=
