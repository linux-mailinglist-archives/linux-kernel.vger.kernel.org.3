Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D224A53DD03
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351241AbiFEQ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243238AbiFEQ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:28:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30361BE1C;
        Sun,  5 Jun 2022 09:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djrNhRoMF97sIygqcclWTmITUAgFcpleOzprKJxGQVI2Aio0DVnTmpC6V+SA2P0GqkFpAjkarZluuN9UtN9AQzYkRwTXJR63a5sBwd3Dve5fJqIfLfubpY0oOuiVzmmAy+q1BKl0AIC//HDyhazXCJb5uRvXp1Qo+5EHQl/xLdWbZ+cAqpP344mpZOEgc2uwr8aqStEiNnRhGOm/PH72IHxyBQ0/THjO9h3PkKop7N55rB5tsp3uA1zaN6ZEDB0RZAhkJ77MCtgj6ITNs+nXrbDcnvhEED0U9KjbuKQs1N3KyOn6dszxX/mhNnxUcBlRcuWX/AOp+zHBG56H/9IcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3OOdFuzdFLKSQrkpIS0CsIS0zf0aDA38dQSkohMKo0=;
 b=n7/ej80qVza4yBog0JCqu6yrvU0VGx81siPuJyX5c0ArnhJI+C4cgxuUjnj+SxdE0G3x+b8k4jsJZFq0zRmTeD9/JjKHNuN3BHFLTEG1WLI0Lq2qiM2QTRINohXAskPH3QirYd3EWM8xLFSacPfCFkl0H4+JuSUhvAeLyO4kiBp7SM2sRoFZadl5Lc7JbqmfuumXpZfIMY2PZ79Pywf94u3/OCzMvzVnrETVf90o6mmyL6vAABGEGAcJYBT24b64a1PmYjJaRQZaTNZr/ZKO39Anb7g7wXwPDN5nGH6ABhYdittuLV6FlWfwq1NnRbDaTzBL0pY4WjBcIztKR7vscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3OOdFuzdFLKSQrkpIS0CsIS0zf0aDA38dQSkohMKo0=;
 b=QRjXDOUY70/ZF+D8/bwXIiXpv9q4qLYBax2J6HTZT3uYakMP8y3QoD1J/8LRv4QKzn/98FJXxCH/AaHPm544FHUjhWCHBe7Jhdm5lcsmoKQm0ytGKehKfYhubu2WThuSiYqwmjCSNzTy08PebGcxq8j5KHVz4b8MH5baDWpn7Z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB6987.namprd08.prod.outlook.com
 (2603:10b6:510:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Sun, 5 Jun
 2022 16:28:26 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f%6]) with mapi id 15.20.5314.017; Sun, 5 Jun 2022
 16:28:26 +0000
Date:   Sun, 5 Jun 2022 11:28:20 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Hansson <newbie13xd@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 1/2] dt-bindings: input: gpio-keys: enforce node
 names to match all properties
Message-ID: <20220605162820.GA12875@nixie71>
References: <20220603101601.542054-1-krzysztof.kozlowski@linaro.org>
 <20220603101601.542054-2-krzysztof.kozlowski@linaro.org>
 <20220604030455.GA12308@nixie71>
 <fd5833ac-2f8c-98ce-a9bd-188c90cda6f5@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd5833ac-2f8c-98ce-a9bd-188c90cda6f5@linaro.org>
X-ClientProxiedBy: DM5PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:3:d4::27) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92555ee2-495a-4370-7d5a-08da47106ab9
X-MS-TrafficTypeDiagnostic: PH0PR08MB6987:EE_
X-Microsoft-Antispam-PRVS: <PH0PR08MB698784E21D653C919950FD2CD3A39@PH0PR08MB6987.namprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykBPJvop62zRjibiCz2F4ui2Q3A+39+resUNdJLwrpFqnUvWfatZxurdXlfyEH1qpcMAjlUo98N9my2bDvqTrqQ89uBV+arWUefEfftYpYhJRZNIOGyexj6lh/JmrXi7GdvEjOAzCU8AVWVy+VcB+w+f5kuEAguKMvsGvGE65B7amPU+XPJnbqkgl9izsCejrDhBKY3EA6zoA5FgZkl8lIsG7qGBiod4cFzNlOy4BIV8kcw0/s4vFt0jH3bkgJ2vDpXay/NfVXOxje19DjmI1UjfiqE7xFknMbyOtnxEmnQvlX+TGXb1UWsYUG3tAt2FB3sHta5aZLzzP/BqBLhRy1HJN8yrQnGoTL/k8Y0Py0RHFo/xr6bx3voTC2Bzh5PBNM94cOpqF9h8JbOg6MnNGRaqByQJS7Oy4tTBKJ97HSq7PoWtioF+1AkjTA8W06By7atVPRUadutfdHZ6YsOevV+oWiqiC4mYWgK2HbSzxuNDLY3CnRqrBjySWNuT+tR3w/JRadNGKk5aAhFYbnGVXhu8kvQQNPfcSKlQXDgUS2atXZ/eR7FLAiJGkCQI/gDWjLsWLcv548JefgppcTSKe6bE0wA4BRoguYdgYcK9Xp6f7lBZYqbliXLelEOPsefo37AYeKPYGw+vNqQJ/DxlFuQ9OFYYViNEXE1UYD6JCdNb88CLt5TWyK0sZXbCKMZuP+Q+pXo1VD/uWNPwl8U81A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(39830400003)(136003)(366004)(346002)(396003)(53546011)(52116002)(41300700001)(8936002)(6916009)(6506007)(316002)(33716001)(86362001)(186003)(54906003)(6666004)(508600001)(33656002)(5660300002)(6486002)(2906002)(8676002)(4326008)(66476007)(38350700002)(66946007)(66556008)(1076003)(6512007)(9686003)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8uTdczMf6ZzIoSlXAuHh7gvQXT5tUVodiDK9wB0UgGYwMeQXFe62jc29rer2?=
 =?us-ascii?Q?gRJhEONNja8k/NNQ5WD5+T6CgD+sQEQd66rGliPENDcP6DdNpBEH5g1up5Bs?=
 =?us-ascii?Q?ecknlBqVxNCD2Iq+7dwckzCil4MxcQMVg8HK9uDDmIPg1tHbd7qpMkClb1S/?=
 =?us-ascii?Q?OFE5Ehl9av8eqkWNTJeNejTTXS3p8G24kb0Mgz1iP14n1Zg6LOX2+v8pq25/?=
 =?us-ascii?Q?PecEkVq02wDgW3j66AtwuhCQtHLO5R939lg6fx1FHfnyEZ5cB0tTsJq7nxBJ?=
 =?us-ascii?Q?/6wvgRoyUZKgVfQf31nsRuma0JLiYENga8IBEOfmWa3F7iibl3K66lklrtvT?=
 =?us-ascii?Q?2iOUSbncUIeIlpHKP3eG0Y7Q/vX1X3nHsNFzSoDn3AYvvi3GpuqcgXrq7sXe?=
 =?us-ascii?Q?l0dqeoBqa6APQt+3m2bmp9L4aDNTndSjapsLPDUkum4Ne4J9TL9aIqSqJAx4?=
 =?us-ascii?Q?X43jexddsZYPa4Uw/jnEFFaL3e35AiFpFsAYktkTE8OcInQD07GdWVBp7OaO?=
 =?us-ascii?Q?nmMlXYCqAcLCs5h3dE6NPkjCKkx5Rs3BEJYqHLvYi4/3DFcDH6qNf3wxqvHt?=
 =?us-ascii?Q?BHcAy7Xu2+QMwH03SG8FxcOvreEHI1u9/h52zylfqUngTrTOe4k8/15iAmwg?=
 =?us-ascii?Q?M8/DIAputVwj60QgDU2N8Oi3W2zRp0vGxaq+mcv2UgBuByDFNJxcP8H2526z?=
 =?us-ascii?Q?n6uGG4jKBb5SvHOModBKVb2pWjsd8w4Uz8Gc68mWmDiIj9bdahksoK//e1A+?=
 =?us-ascii?Q?BmikGwnHXrML7is69xSAT1FwRuVMlf6cWx6E7nkbx22zc4kEZmXWjDlLOB/j?=
 =?us-ascii?Q?MDiuwGLmsjxVTDCPvKC2p+BHQxVu56JzSwMK8MfrgjRbLkIM1K8flVaJgcsT?=
 =?us-ascii?Q?fLN6Rqk8JflQnBkopR7SQ/TpqHQuG/31jWKM0wHcI0bHmeDXFoln1fav9cgv?=
 =?us-ascii?Q?YXXIheVwvxBsa7DW0xJvQtgsgOHyriwvDbzqPNEsFgM/o1JQ8yaM3TmL56Sa?=
 =?us-ascii?Q?vzmnURoeMwH58JXTjcpHmQjfmhbmT//imq9JDma/wQH7uRSTpxWJkF4xatOT?=
 =?us-ascii?Q?d0rr0HvGr8cCuQWtsdNahKdjGGFr1nKORId0VqgfchbrlqNOf40VoDySQa76?=
 =?us-ascii?Q?e2uxffr8VKfpyBEXs8ySF3CJrWdQI3YrSzZvht71S2RcWMExpXxJa++e6PRb?=
 =?us-ascii?Q?MI6QOY6IM7J0D44TpuGqBk5xaBvEOnoW//ID8IRuKXZFxsGNzsuwrygtYiuy?=
 =?us-ascii?Q?CwzDksry2HkIV4Vh93RhzGPjbk6wTgDcM+kGz6LeFEy/iGotJGVYlJ8WNhlU?=
 =?us-ascii?Q?aDl13XfWfinmUuLnvCNDEcx4v8wMqLIx0yQcMKqWJ0NC/vbBDfY73JxTazs9?=
 =?us-ascii?Q?/Xjb7VKfdej7VLuwxoFRaotpKebroOct++HcP+Gf/60H3z8i6n+Ne0tlovml?=
 =?us-ascii?Q?s8mKb+tZKIGbrNnjxuoJ+7uUXxBd2nLhNaZDXmT3TL0GjUQw/vxjCI2ifG31?=
 =?us-ascii?Q?M7BwPdmb+Vr/DCvmJ4At4f4fhoTV299GgfNQQTpRe44BbSLSV8GHHKzpUH+R?=
 =?us-ascii?Q?CX19XE1lOod2SIJhZzNaZp8MObiXSbiTSZo0bev4/7MmqrCztiTe/ylUKJqv?=
 =?us-ascii?Q?SlvTv9qmwLA7EqA8GQ1TIlm/MLA3uAbAih5MzfP6SYx/lCAvvgm7eUVbKFm2?=
 =?us-ascii?Q?p78moYMQNRBEi+n256h9AW25mYAqmeVwvPBbSlp391BYHh1ifz2m8Rk8KKIK?=
 =?us-ascii?Q?jxrLRMGJyA=3D=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92555ee2-495a-4370-7d5a-08da47106ab9
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 16:28:26.4436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mVSd1kUPAmJuM0uvguq8crnzFR762H3r2VG5wLWyyaCBrrZVoAwJt+ciPIweQ7KVDu6BJdcNdIss2bQhPjnEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB6987
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, Jun 05, 2022 at 05:12:42PM +0200, Krzysztof Kozlowski wrote:
> On 04/06/2022 05:04, Jeff LaBundy wrote:
> >> -      dependencies:
> >> -        wakeup-event-action: [ wakeup-source ]
> >> -        linux,input-value: [ gpios ]
> >> -
> >> -      unevaluatedProperties: false
> >> +  "^(key|key-[a-z0-9-]+|[a-z0-9-]+-key)$":
> > 
> > Maybe this would be better as:
> > 
> > "^((key|switch|axis)|(key|switch|axis)-[a-z0-9-]+|[a-z0-9-]+-(key|switch|axis))$":
> > 
> > ...or perhaps a more efficient version of my counter-proposal.
> > 
> > The reason is because it is confusing to see a lid or dock switch named
> > as "key-lid", etc.
> 
> Nice point. "switch" I understand, but can you really have "axis" on
> GPIO keys? I had impression axis is related to joysticks.

I do not think it is very common, but technically we can use gpio-keys
to create coarse sliders as follows:

- linux,code = ABS_X (or ABS_Y, etc.)
- linux,input-type = EV_ABS
- linux,input-value = 0, 10, 20...

Trying to encode all possible values for linux,input-type (EV_*) in the
pattern is not reasonable, so maybe a compromise would be to use 'event'
in place of 'key|switch' because events are what we are ultimately trying
to describe here.

That being said, these are special cases and I don't feel strongly against
simply using 'key|switch' for now as those are by far the most common use-
cases. Another compromise is 'key|switch|event', with 'event' available as
a catch-all for these special cases.

> 
> 
> Best regards,
> Krzysztof

Kind regards,
Jeff LaBundy
