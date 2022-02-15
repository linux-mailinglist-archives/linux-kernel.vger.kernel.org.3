Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18DF4B67F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiBOJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:43:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiBOJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:43:53 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C49E543E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644918220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ae5PjJ+Ev/y6BUQoglqLNZsoMTZzF3tXsn5ogVczADM=;
        b=h2xRU+6yAHsf536auMpm1cwA2WEVixxL14umtx3tGw/WPZhldahgBK5kt8WOqdFVIXOKKn
        Za1zj3JuuvdFaYlyS+cl87v42QK2iajSSJiPEpUEt2kk4rG8IRMwkUdKyfFo19BOA/ntBx
        5JaOpunsI9H7KL5xe7G23EqfHC6hMSE=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2051.outbound.protection.outlook.com [104.47.0.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-2VZzoYtcOPmfz_4WMO57uA-1; Tue, 15 Feb 2022 10:43:39 +0100
X-MC-Unique: 2VZzoYtcOPmfz_4WMO57uA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEQMg3z6hn/dIRnestQ5i7RmdjF0v5Qa4c1Oxiyhv5QryYbaJCD+QrC1XD3RIqumYZSG1CEhqcFUC9qrYa42bpWZ3tHFpfneuRQI1J7q3Yzhuj3+0BCzRGDm2JeDSXzxvhGFRKB5qbaxLLKgab7+Byxm8IIr3d66868UQaKKWHatkCIa726qvPAkJAdbGOvEolg/DQeOI56Jdp3E1pMkbWTJAfdrUZCI5XD+r/ZIMMlfHA4Jsjos9eiJVhcm58kWsuGFwguJCKeHB3D15fMuUycl21scKcxJxC+0heHDxP/DXrujWMJXny77E/asBaXvYxdOMAQGdoLf7vhd8I9b5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avKtqVx+U4efoFglTtF2j/oidk95GIkpaixuQlWK+Qw=;
 b=WGBVxjgeCZWsslV8N70W2uJ4MIdrXyQTAUxqwt8IoJ6MWU1+b+YLExed2jitTkMMtx8PLLeNslL8J56nbdSPuDuO5c0n/nIkM0rONKTn4ijcR6zd/G5ER+vKXIp/oWetdkb22jpoDGCO4Y0yjXt2oIkqWqjgPKis0YDmKDEjrbzwTQrhGAiOOOT8TbUeryc1X+DaCq64Q0qVHZy3OCkq8hd8Fgr71Uay+jVeZxXtrm+TQpHQ16epO8HFUpDsGs1wTKJqGOYy+y69UK9IYH6FUSUV9N9rtvmrsAfH9wo92TPSmdt8llCGVp7u1FTYmOKxjkMvhOcVLOe+kjL71RnwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by VI1PR04MB5566.eurprd04.prod.outlook.com (2603:10a6:803:d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 09:43:37 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::98e0:cb7:30fd:254f]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::98e0:cb7:30fd:254f%5]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 09:43:37 +0000
Message-ID: <db6c18cd-73ca-f7b3-d5b6-fad9b3733d41@suse.com>
Date:   Tue, 15 Feb 2022 10:43:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ugoswami@quicinc.com
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
 <d82746d2-4096-1477-42dd-fd393e0ff827@linux.intel.com>
 <CGME20220214135321epcas2p19dc7b60c27304181a8863248103e7493@epcas2p1.samsung.com>
 <20220214135310.GC31021@hu-pkondeti-hyd.qualcomm.com>
 <20220215085108.GH144890@ubuntu>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220215085108.GH144890@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS9PR06CA0414.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::26) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f264b86-0c3d-447b-6dc4-08d9f067a3aa
X-MS-TrafficTypeDiagnostic: VI1PR04MB5566:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5566E21DD82A6E5022F7D496C7349@VI1PR04MB5566.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVFXYogtZQQb/jyYr9f6ZhD+F/ZN0c+6TAIc23UoVF8bjddD1kKPL3/l0H1qgOGxV7ptq8132T8mwWsL+hXYYBSN64AOqoH1TjCvI9+UsRd72MeL4vGQlSjPNcOnQqcqcUm74Edav7Qpy5ydbI9vehD+o9x+8Kg0etvT5u2qJ2cbAM7LiEcddy0E9JyVWbesQSZsj9lBg62V1TswWdQPuiq+l9WYV33WpwEl/fc5FV4bjd6oQHubZJ7ly8DOKcx2jwuNyYJL0DyltozavA6l7tEEs7zyltwyu7DUKMNFinwM4SmEueKNu9jO03NB5rhJD6fX+M7hrYYzVoVLFjIyD0a7G8Zl18ArjOCRiMPIqDFnoy40lj17BJEu3ZWcsSxp/Zh5gXSvo+XMAE5WG7qwjk9fLIxLOF8JQZq6t4UR43WLhq7Vr6bKNBNlmaEjuG5IL3IlesApylpyrbDaM17kHMOkOKcQXWnxwVuR2RpgWCHknqJahm/jhZpzfN9s3LDc/RgHCl+4EKWAqoEOn94iBx12Cu6GmXnEd5FmNdOHsb3r2lZtQftj7M1u5M0CHMPW3QCFoLKNR2bdsq9XNp1blr9Hiz1C/dLY1RDN3kuDtpyOJBKZnNIbk6fePlWUy6ATRqrjiTPwqUXDSaOkubfrwS2sOyHD8VetezwhkU1vY4HStUw7nryEhobwlnII1DQwhL49fFJ22M1P26PUf5r40qHKxEx8BrvHgNl3q+o5PHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2616005)(186003)(66946007)(66476007)(66556008)(8676002)(4326008)(8936002)(6666004)(5660300002)(2906002)(6512007)(6506007)(110136005)(54906003)(53546011)(4744005)(508600001)(316002)(6486002)(86362001)(31696002)(36756003)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YwvjIlZB4fL4Nu0HmG/C7dn5zFSEFRHP7IkuwnF+ZzLy4t/rKNuGJFWKmoUz?=
 =?us-ascii?Q?FawXZz73Yxqr8sgj2FLf9A14ZySLbZCR3x85nuFFxlGonPuiHmZYfzToPVkf?=
 =?us-ascii?Q?UvfIdiKbMUEK8dXI9PN6l0SiOyJz4koa8WxNzGFDeRh0s6PN/nuyahcNaYdF?=
 =?us-ascii?Q?WtkB5oXEk52bRVy/kqmj5firH6CkOXCnTEF8INhUF9zUHQHfz3q9YMlHqlnZ?=
 =?us-ascii?Q?/PBMxhGtpLyqmWCvwA3CTa2mRe8WEpRXnhDZ/0sQtP+WnHFRzPxibPyXu5C3?=
 =?us-ascii?Q?JaNI+kolLr2q5+RbJX5D4hmhLxzsvbTOC40W0SGnjWsmLQ+jHN9ka21hJqbs?=
 =?us-ascii?Q?Dx4sZy7BToBkPk7eZuSBdjbY6tNKwDvh+uy9RIF7V3Lr+TMnIgfGKbcLc9CB?=
 =?us-ascii?Q?c3vD+YXZyiBD/w1zw338NlwHz9rypQvwGTaPXpjJZL4F4DjpsNI63jlL2jZ1?=
 =?us-ascii?Q?egAtAGNmExh1FLzmm13oQSRgi8PZO9LQAr4E6UagN/GA5Cz7SspU9cK7KJk8?=
 =?us-ascii?Q?5S+CtKsvrhmhbRDfcapsJ5fMLo/So3ZwE4D85INYRrOrdGgkQVrVSKWItld3?=
 =?us-ascii?Q?Y41M8kPCpMg3pobUWWPdDjqFkANX3uCpZGCuRFX5YDZc2l8pa4jjSzzvCmsV?=
 =?us-ascii?Q?E6CLfRGfvyS34mPibGrxKsWszYJFd6RDKjFmMvQlgYAgOKng9/zvP0mPjdmh?=
 =?us-ascii?Q?LzdEA2bISrLLOuh/iqpXmcHrj4qfwAItBwjmIUe1hMPEKhw2AELQ9FlNlFA+?=
 =?us-ascii?Q?GzZjd9jOuuSyFhGpyS6zX5tQ6FSF9HVnyIgLuFD7xpqYF6ulNl2pITcoqj24?=
 =?us-ascii?Q?c549VmK04EpmXDEGmJT38N++WzJHFao32H7fh0dVOE6MVr6jjyoyKqBC1MhN?=
 =?us-ascii?Q?IByXZL+E/PDSGF6tLMjEDRro3pZAJC9vBXbbLzMbufVESedMH2+fcGRNtXMR?=
 =?us-ascii?Q?v+Ud1Yy7HIJnabAuDcRYi5hpUyIiwp+dGHTITcnoPJLi3ipx1FvJ7+Ch3L7E?=
 =?us-ascii?Q?I8XMfXooIB878afuIVROqGOTVUXBDeCsbmlxmev1VqaOmRMzyJzv/R9l0W3w?=
 =?us-ascii?Q?35uWM5nOqyY2FIRdz5l/RaJMEuoEpkWNAoaEt0l+c46qHjpCsYO78551jAJd?=
 =?us-ascii?Q?3+mB9wvCJp12iVWa6UryatVYaxs0gXZAt1GII0pmnPkcKhXnOFMas5Ti+TGt?=
 =?us-ascii?Q?BDPTRfqp5nGY/sFOPsuYlnFWIUImFJPE1H+pCuNuKO2WdHRteN3434oP4W4J?=
 =?us-ascii?Q?7I/DGzYo3IZtAPv1zTeoS1r1+oiWFjqYHgt94YJNdnbFD6oyFS48s2ryGor3?=
 =?us-ascii?Q?5/6LJX+OTvtjjBiND2JAlR2/oose+GpTbq8XuuMZRwokZQQzxW4kYPsHYkl3?=
 =?us-ascii?Q?5548thuuDbJ+GOFDsDAUnf9PvP0bNssxUaev0DHppi0xrpfc1paQoxWQg3tu?=
 =?us-ascii?Q?ONVRYBxPXRP7zjInx0PxQpG9TBs1QeWX1zTG3VQfViWtrwbFko4S/lc2zSHs?=
 =?us-ascii?Q?JYmlpVfqX3PXb5trQcrnPEUhAS1h3Jc1eFiFxkFIGwm/tkvja+WtMpKw3xCK?=
 =?us-ascii?Q?PCFLR9k5980l8hgvG9LcKoHtFJLPPjt758cFDit/wgo0N2+BkNRqjQg5Hw8h?=
 =?us-ascii?Q?GxyBCWEbOx9ZjqBkJQbZQyE1YFCMHn0fLf9OizR6j5MwQyWums5JBLsorEHq?=
 =?us-ascii?Q?uNMhvHRSABNm9SdNldDmVsf4z34=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f264b86-0c3d-447b-6dc4-08d9f067a3aa
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 09:43:37.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwVI25x6Ra2d/x/0jTaNpseTD8dTgYdt8xoFQ1/yTZ3tvzQtaGab3tc9dnQO1W6lJ6hzvf+dX8o2EIYsQN2bXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5566
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.02.22 09:51, Jung Daehwan wrote:
>
> I also think it doesn't make sense 10 secs timeout with irqs disabled.
> It could cause critical system problem as Pavan said. How about adding
> new quirk for different timeout value?
>
Hi,

I am afraid this amounts to putting bandages onto a fundamental
flaw. We need a version of xhci_reset() that can sleep and if
you need interrupts to be off to reset the HC, you are doing a bad design.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

