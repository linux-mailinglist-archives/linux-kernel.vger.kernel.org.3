Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B6746B717
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhLGJeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:34:04 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:29417 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233915AbhLGJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1638869432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1OZbPiULgSjoUgInUcdkThKjNW3pkPz8cyjQDpNzI0=;
        b=HgZJaQFjxR9qcJJV1qzKZSx57mGjBSyfZCOpyyYMHWZ1G13Ar1qujf/eObchy8T5VxKKGx
        hp4khcOmJG6aOIiY1q/kGsrHCAsfRMI5VaNPfI8Y4c7nuOirV73sHxnqYSXvf/VTwkgXzO
        LMNOnNaifIvg3RemQM4m7fyv0ng1G28=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-LE2J7G7JOcKiU5NimQgL9Q-1; Tue, 07 Dec 2021 10:30:31 +0100
X-MC-Unique: LE2J7G7JOcKiU5NimQgL9Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPRDbhswUr06J2/A3MR4V7jutStf9CU8K7d1JSpYCKQfHQNeOtMPMxZRxNyaGV7hCAGo8cz1h03QYn50OgjfVIlTxbylWgNpcpz0d/YCcUJd2E3w989lE8QCzb+qpdtnraPypEIY3yvQBv4b2OdDK74s+8iQH84QaCvu7HeTeWS6qF6NQbPEgOSTSDzOYUA0vkrwgvaAkrTXB0jKGrAk3EDkFiWcA18RDkzEsyc5qcOpp6hiOzx4kCDAoSF5VQ9IHgy5zr4v3cvWUJIcLf2l9rMfKK4XyPzO/Z9gJc1HL1DoOfOTk6rIO/i3FRs4wT4sLF9JGt/J+dlLHkJ1qgKqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1OZbPiULgSjoUgInUcdkThKjNW3pkPz8cyjQDpNzI0=;
 b=AWeaPBS73Kkxq18JLNyDYPqMYUGk/gQldbO3kU/6lxWl+vommCCVUiZvcla/xdcBcsxcS0IUrUEvV3ROGYKMSfrBG7LO37k2OBZkbCObvNcNbxRnXgE4VlU0mb393RmVIrWTmUiONkIYQbiNl8d0LFpAU/X5WyFpfnssXV8dTPUaLBnLk3pDURcxP5uyK1MURDiFGn4CBfY1nrDoeTSe78rmaIOy87AoF21qJUyuE8X1JKZ1YfgEIG9U7Q8GB8GsJQxrl4pcNzVJBFYDCBMXlf4jAmSTbd5he26Fkq6cDZcsH0L9HUvojz39YzZOw7+NdIb1n6u2iEjOB1Ns0Dyy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB3PR0402MB3738.eurprd04.prod.outlook.com (2603:10a6:8:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 09:30:29 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1%7]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 09:30:29 +0000
Subject: Re: [PATCH v3 2/5] Docs: usb: update comment and code near decrement
 our usage count for the device
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
References: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
 <ca8fd26ccff6521c7477a2035e703e099da56214.1638771720.git.philipp.g.hortmann@gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <bc30a2f4-a913-1f5e-c1fa-e10f8f357128@suse.com>
Date:   Tue, 7 Dec 2021 10:30:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <ca8fd26ccff6521c7477a2035e703e099da56214.1638771720.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR04CA0160.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::15) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
Received: from linux.fritz.box (2001:a61:3b82:1901:9d6b:5ffd:1b6b:2163) by AS8PR04CA0160.eurprd04.prod.outlook.com (2603:10a6:20b:331::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 09:30:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 645760de-cecd-4de6-eef1-08d9b9643558
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3738:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3738EBEEA5EED3F5E0FC4720C76E9@DB3PR0402MB3738.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFKmC/7Cvxg85PtiOloXalNLPFVY67NJsPsKh9GxzaJBrkCPD+u0/XGSd/CH41Lsps5oMVeZnvcLv3KySUu6UevlDT+2mFDimag2VvB3oertAtBmmdfkLua7BDBhfPF1AWybZvVsTi56O18Ux8HSUX6QE6DVybuBCLAqbskl2KoZzdhwp/Ux0IzVGdVjyMPDAY+oxl3TNdws3FmHkMRZgfRTjWNN7OZ1vgyqGG3dYw58BF/NJuFaRE22gQeA6cWX7nweqQauiHUKuzA2H4g4vySj61Ad1KueuNRnt7wzNC4k//jlhphD0ztbZiWhg23At9SQ0bwB9p16p7y99idwA65RIRBsyUXSYclZbr4yX/BdfC/PKUGRNcrp3l0+MZJaSm+d9Z2oLlwIfXP4H0agKMCrbK/2WX2EyF5elTJRhrz5LuQKOlh6uLU+3OeXgz5yj4ZvzCDNs6K776Xgi3V/fjhJ54fnlDslGiNzslplCD+BECXhrbVmQxf1qAAejazKzVCHYGcXECWbTZAoQlI8fG1Kw/PQfXWIWmDwqdcz+AzYSQlpSvVLEwbZNnEQRyqxkT8API55YNhtAmoVqmxEUMyiaM35JoDw4ccd6qhvfwn0hzmjnyMfQYJym+GquHPkUEBycsSp7m5nDw+tqpgRzMy/WY9w0LXmh0NfFgFueVswbUZfsldYBgzaG9gyPHbYkQMtfS/I5Q3sOxm6Ta9Y5+QHAAr1Kl/vPNMZ79ShNeXSZl5flXSL7Bo7TeNl8IHq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(4326008)(31686004)(31696002)(66476007)(66556008)(8676002)(66946007)(6512007)(186003)(508600001)(86362001)(36756003)(83380400001)(53546011)(6486002)(5660300002)(316002)(38100700002)(2906002)(6506007)(2616005)(15650500001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZuamtuQXBoaTNSYjZ4Q2ZqUmtDSldsM1FmWFpEZWNKa2FBNkRDcUgzMUVD?=
 =?utf-8?B?c0VhZ0xzSFNCeENCMEh2cnZ1eTVnNjZ4SVVFSlVlK0VIVTFRUmorUnAwbWxF?=
 =?utf-8?B?eWd0NmUwUFJzK0JLTURtVm5JekhDVzI3aThNNkw0ZStvNTFEL2VaRE9QaDFj?=
 =?utf-8?B?YmxwakZobEVwZEZNY1oyUGowZHJxckljNmVWRlpZNGdid2RhZmMwZnQwZ2tJ?=
 =?utf-8?B?RHFDV09JdVhQRDhJbUdMa1c5ZXFwcGNBazZiUitJcnM4REVRZHQ1ZE9jR1da?=
 =?utf-8?B?ZGVzU2hsTWM3Y1JHbUNzclBkaWs1Nytkd2pLOUVhVEFxVjlBTmU5eFlUUlQ3?=
 =?utf-8?B?ekNYU3BJTlZvK05oSDFzbG9zNGh6OEhVWXF2cVloSk1ObDhoY2pNZGE3NzJ1?=
 =?utf-8?B?Q0s2M3dpdmRsaW9iNGE4YjI2UkY3R0VUZjdHUkE4RE5JUVVIeFI3UjB5OGhV?=
 =?utf-8?B?UUl6a2JreWl6NkIvSVlWKzhHSzFxYWlUL3RuRWYrMlR5eGM5TzQ3YmZrVEJh?=
 =?utf-8?B?akJudEozNy9qWktrREgrR3hmZTd0NHU0RU1GZW1WQXJaQTRXOGtsR0Ewbk04?=
 =?utf-8?B?aUtlNXVOakl0K0R0YTQxcXluS0tEYitJOFNJZG5WNW9NRUp6V0MxQ1pWRktW?=
 =?utf-8?B?SWRsT0thdnZRajVQeHpYTTNubFZqanNaTnJ6S3ZlN0V6RkM1UTQ4MEJOdm5F?=
 =?utf-8?B?UGZaQ0dtVU1hMjFDOE9yRFc4Tk54ak5CSmY4cGVrTHV6UzYxWElvSDBGbmVP?=
 =?utf-8?B?aGpRaVhRR3NzMko0d05sU053SWRRNEpld25lNExscHVGeHBFQWJCc05BSFpw?=
 =?utf-8?B?Zy9tU09ISlpZbmU0aWhidllzak9BVm9hZkJKT0xWUHlFSzVqMnpNQ1NaVExW?=
 =?utf-8?B?RUoyZkxVMzRtNnFFdDhHa1RhWmk1WGJmS2ZubjF4a1ZnOHJrL2JpbGRWd3Va?=
 =?utf-8?B?MU1MYjZDcGVpQStIdnJlRzh3OFJINDROakQ5S0NTUENWVVFpVjdEQzJ3Tzdv?=
 =?utf-8?B?dlZWVlBXYWlrdDdEZkhmZXFWVUJKQ3RRc3ZSdVdveGliYVNVSmo5WXNTd0xC?=
 =?utf-8?B?eHptUDBlaFlvdXFUR2w0elFONHJMZ284TmJ3R2swdXRJZnVQQWFGMGZSTmtj?=
 =?utf-8?B?TkIvTHEvWXZlcWM1UGZQWXE2aE5manlkK3RDR0t2b1J5d1E5WXBEbjlWbUEv?=
 =?utf-8?B?S2pBUVN6Q203OU1wN3plb2FxZWk3OElDN1YzTW9WbzBwZjhDZG0wV3NRMW9y?=
 =?utf-8?B?V3FFWWVMYmlEZFB6YWxROTRtU0lhd2V4azBZeHpCMEFBOEFzci8xeU50dmND?=
 =?utf-8?B?c29lWG84RDRLRkpsYXFJdTNnallxUk5rVm5oQSs0TTNSeDRHOTZrYUNuNit4?=
 =?utf-8?B?eTFTN0JGYlE2R3N1M2IzaFVkYjJMYmljeFVyOTBHbjZsaTd1d1hJRU1zQkJY?=
 =?utf-8?B?MmVpcDIwdUdCK3E4bmhpNlAyb1BzZkJtK1ZIZlNUMU5ibUIzTC9QRzh1eUMy?=
 =?utf-8?B?Y1doVTAzS0dST1lQVFE3OGVWYlFPVjJBVEJ1cmErZGYrbU8ra3dTNGFFdDhx?=
 =?utf-8?B?ZFBUU09OTnY1bGwxQWgzWnpjNTdyRVhDODZCNmQ1ajVxZjZIRTliS3NZOXRs?=
 =?utf-8?B?UGZiMVRDWkhxRnJyNWhyc1lScGt1NWJNVUl2ZjloWVo3bVVFVVIzZ3ZKampK?=
 =?utf-8?B?WjhyZEJva2xFNklaWjhXUWpzaUNkZ3ZHd1Fvajl4MVFyeEpEeWZoUFBnZ2Vs?=
 =?utf-8?B?MTlIYXFzUGs1V0dlUmVRNFFNa3NYOGZNaVpzYUlyN01Vc0xJV1g2REtRdVFt?=
 =?utf-8?B?TkthTkZNNWp6LytpZG5vdFhmOEwyd3hTRm1PRjhlSFpMb0VqYXdkY3J2ZnBQ?=
 =?utf-8?B?MG9lMFNxalZoNVRTcVVva3Z0R0F6cnhuMWdVY3BRcUJpeUozYUJlb1R1NjVl?=
 =?utf-8?B?TTk0ZXRNRUtBSmpaNWNrNVhOd205YXhqbWF1L09tbHY2M0JPMUVTQTdZUjRo?=
 =?utf-8?B?aFAzUnhZZ3ppdThGTWpaOFhpNVB3dWMvTmNvV3dDUkdMemtvLzN0NEpGa0ZZ?=
 =?utf-8?B?eXZHWS91Ny9aTG5wVjhvcVFrNkZIR3pYUWlUSkF5c2JvSjhiTmhjVHQ1SnNX?=
 =?utf-8?B?Y2w2U0QyN3R4VWlDNG1qcUhCaG5OMHFXK01WcFc2OHloUkw0WHlrS1JqQUFX?=
 =?utf-8?B?bTBrd2g1ZC90MjRpdlJSK1luSDJIRENOdjBuQmRKa0RDZEhCdTNRQVQ3TkQ5?=
 =?utf-8?Q?u5gUBi5yzPiedGB828GYxk97j/Wlsip1h+dwG6rwJI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645760de-cecd-4de6-eef1-08d9b9643558
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 09:30:29.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDEQMLLNl9+CgFWkVSGqek4QRC6fkhh4o/2MsPSpF7acuz3fLfPrC4hIQC231vqIqJkmrxQ1qDlVSsGMl/MW0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.21 21:57, Philipp Hortmann wrote:

> Update comment: decrement our usage count ..
> and code according to usb-skeleton.c

Hi,

and that is exactly the problem, I am afraid.
Your patch would be correct if the underlying code were correct.

>  
> -    /* decrement our usage count for the device */
> -    --skel->open_count;
> +    /* decrement the count on our device */
> +    kref_put(&dev->kref, skel_delete);
>  
>  
>  One of the more difficult problems that USB drivers must be able to

I am sorry but the code in usb-skel.c is wrong. You grab a reference
in skel_open():

        /* increment our usage count for the device */
        kref_get(&dev->kref);

which is good, but in skel_release() we do:

        /* decrement the count on our device */
        kref_put(&dev->kref, skel_delete);

unconditionally.

Think this through:

- Device is plugged in -> device node and internal data is created
- open() called -> kref_get(), we get a reference
- close() -> kref_put() -> refcount goes to zero -> skel_delete() is called, struct usb_skel is freed:

static void skel_delete(struct kref *kref)
{
        struct usb_skel *dev = to_skel_dev(kref);

        usb_free_urb(dev->bulk_in_urb);
        usb_put_intf(dev->interface);
        usb_put_dev(dev->udev);
        kfree(dev->bulk_in_buffer);
        kfree(dev);
}

with intfdata left intact.

- open() is called again -> We are following a dangling pointer into cloud cuckoo land.

Unfortunately this code is older than git, so I cannot just send a revert.
What to do?

	Regards
		Oliver

