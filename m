Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089EA464569
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346440AbhLADax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:30:53 -0500
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:27873
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231315AbhLADat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:30:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGtCRoN+6wF9WcI4jpaCJP7vQJwIwdZYirUNmKN1G/jEqL3qZHu5c2QY/4tSzAbGP0OHGQgqzXC+KBIBjrMExz1YO2k8CAJZgFQeNzwZToA7+ZFfNOCUWbq6LAM7OVysXw1dHSdmlsanQokOm9TSigGLdAzEtkxjZDtPOFy/zzOJknWFluGiGsPK6V/wWNocaogC3KnIGCfWz7Kcc90d5MZ9iTJd6NLNvnoVFZmUJ/PiCbNipasWdTJpLDfGII3DHXUo1eG7nLZrMR1yn8sIpo/WgAlOQBfbXwUzYorWVm/N+86S2t89pRyaWcyW8ZIv9apaP0BGEjtBzvbRDEh2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FIVR9wjSUL/ueHECeLQJPYGzGLsxM7us8lSWniboCc=;
 b=Yano5R4/7fToKCFmDLbQ0lFgF/l5zbTnpyHFsXbCrYf2IR8IIxZnzcljre/z6iNUTshp0BH3rfiv9ptxZCUNq3QVAv/XPT5TEEpp/lsAiLhmFlY1lbKRixq1pH2b7jWMIJZfRO6QFWQlERRtLtjDzOdbTToIAa6QeoZcweyOsm0WlcdSgty9LsgQTZIRjT7ibrZOqXRmyWCJ4h+ZZx4ajyOj40eDL3oV/RIlCg7AAVp6gjg6ghF2vrqYCcQjYsyDiWoWLHJNvoofsTeYSJJG15SqHyiFJQ4qmU3KcBPucUJJgrGw7Byn0sPN+T3XyxhMJ6Lx9SMJlUQz5eWftBV5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FIVR9wjSUL/ueHECeLQJPYGzGLsxM7us8lSWniboCc=;
 b=Wvth/Tga+QPQt6iCMlPINE5g40p0JM3Hj08srtvEcrA1R0hISYxWv0CeEMBDXfWYz5ulnXPXJrU9ReEcFgeOpurxBjbydNabPdEngVWnRv9PowC5pDvpkoTcsn02WmHiK4qtlhb7yKPLwJBuCKAtDALPIaIDrsoydH1dxlkFGhooX4Iab8AoNHEDL99Ov4hVPg+fOth1uoGBD4Gu87bN3LNZGuKF0fIHTwa5hnTMtx2+cDQ+jEfjyQoAFMSR63LcXyj7pr3NJGYTpNtZNlUG5C3agWTNGjc1cWHtdX8iYbyEyyKjxuOeV/rRGFPRVtxccx0fHVizfdPHkSkHqtaFSg==
Received: from MW4PR04CA0363.namprd04.prod.outlook.com (2603:10b6:303:81::8)
 by CY4PR1201MB0038.namprd12.prod.outlook.com (2603:10b6:910:19::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 03:27:27 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::ea) by MW4PR04CA0363.outlook.office365.com
 (2603:10b6:303:81::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Wed, 1 Dec 2021 03:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4734.22 via Frontend Transport; Wed, 1 Dec 2021 03:27:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 1 Dec
 2021 03:27:26 +0000
Received: from [172.17.173.69] (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.5; Tue, 30 Nov 2021
 19:27:25 -0800
Subject: Re: [RFC v3 09/12] gpiolib: cdev: Add hardware timestamp clock type
To:     Kent Gibson <warthog618@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
References: <20211123193039.25154-1-dipenp@nvidia.com>
 <20211123193039.25154-10-dipenp@nvidia.com> <20211126013137.GC10380@sol>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
Message-ID: <9ad666ec-eedd-8075-73e6-1e47a1eb228b@nvidia.com>
Date:   Tue, 30 Nov 2021 19:29:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211126013137.GC10380@sol>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d48c227d-4ff9-43d4-df67-08d9b47a7f87
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0038:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0038B5FD38B1A211C4F198C4AE689@CY4PR1201MB0038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9ayYBXONZ5Q0fc5eQB0rIhdhOKfA/5Ri9ijhrQmbRvqiXhnpU54fOYFCUePyPmODRjntCCyCJg4iwrgnurf8HsvpFH8N6JPDvFA2bCNu88THnPMvqcq7EMhxXBuhBbZv31iIxsQ6mVKlcn6grzVen6/6mA2ZtzDTbfIyDya1KkRBCs/1Qu1woHc7vwAOV1BNjhQN7WVHj5qUPRYLI5AzLDTuq1YnoRW4/zoPX9ka1mjwH1Zxe6D5uGzcYTbHhyPzSW4CS8b5mB1Hp+NCfrLfRw5sket4xnj3t1ItQClTiGSpAva8jd4DLvMJGYHCD4eGllC4Zf8YvG9OgSU8dJ4pTFWj7ZUN2NKGZgD/1SOpVphLJSCEvaR3kapKC3TTWekwhFrKNkpWZPZgQe1b1jME9eweealf91jjgNwiIx0hFgRiszBDdwna6uss4IubZpV/7HkYMOIIRPSJsWvYI5Bgd6d+DXHdq81Wn6CKtcdzvxXbErHHSuieQO3+9ozLMthUlYWtT3S/RBCcweq85cQ/+CVW24Hs7p1aa6CvO9IN4NX5Sn833L6s1emYPN+3nNF4bHnvysKOsVBR4yqd6jlvJ2TGq45Lc79Rh9bYJv8EJmMkLB2OoT5e0vwCei8Niu/vzsBymEFHngkWIgBrYSxjM1d0vyNfytIuAJ+a4zti5z1VNvUJNRZdNkyRIgvtMdzuBTUzxtIeyctMJzh8OmdWOSpNhc8v8bHp0I4ZJsIf1mJg92SRYoZXy1n/yiJeEA036LpVa4GpKGQ4Lxnl9BRgtGFMIT5+Doib7qvbiwNF94=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(7416002)(186003)(16526019)(31696002)(54906003)(4326008)(336012)(8676002)(426003)(5660300002)(31686004)(53546011)(82310400004)(508600001)(36756003)(86362001)(36860700001)(2616005)(70206006)(6916009)(7636003)(356005)(47076005)(8936002)(30864003)(6666004)(70586007)(40460700001)(316002)(26005)(83380400001)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 03:27:26.6807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d48c227d-4ff9-43d4-df67-08d9b47a7f87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/25/21 5:31 PM, Kent Gibson wrote:
> On Tue, Nov 23, 2021 at 11:30:36AM -0800, Dipen Patel wrote:
>> This patch adds new clock type for the GPIO controller which can
>> timestamp gpio lines in realtime using hardware means. To expose such
>> functionalities to the userspace, code has been added in this patch
>> where during line create call, it checks for new clock type and if
>> requested, calls hardware timestamp related API from gpiolib.c.
>> During line change event, the HTE subsystem pushes timestamp data
>> through callbacks.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Changes in v2:
>> - Added hte_dir and static structure hte_ts_desc.
>> - Added callbacks which get invoked by HTE when new data is available.
>> - Better use of hte_dir and seq from hte_ts_desc.
>> - Modified sw debounce function to accommodate hardware timestamping.
>>
>>  drivers/gpio/gpiolib-cdev.c | 161 ++++++++++++++++++++++++++++++++++--
>>  include/uapi/linux/gpio.h   |   1 +
>>  2 files changed, 153 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
>> index c7b5446d01fd..1736ad54e3ec 100644
>> --- a/drivers/gpio/gpiolib-cdev.c
>> +++ b/drivers/gpio/gpiolib-cdev.c
>> @@ -464,6 +464,12 @@ struct line {
>>  	 * stale value.
>>  	 */
>>  	unsigned int level;
>> +	/*
>> +	 * dir will be touched in HTE callbacks hte_ts_cb_t and
>> +	 * hte_ts_threaded_cb_t and they are mutually exclusive. This will be
>> +	 * unused when HTE is not supported/disabled.
>> +	 */
>> +	enum hte_dir dir;
>>  };
>>  
> Documentation should be in present tense, so 
>
> s/will be/is/g
>
> Same applies to other patches.
>
> Also
>
> s/touched/accessed/
>
> dir is a poor name for the field.  It is the hte edge direction and
> effectively the line level, so call it hte_edge_dirn or
> hte_edge_direction or hte_level.
>
> And it is placed in a section of the struct documented as "debouncer specific
> fields", but it is not specfic to the debouncer.  Add a "hte specific
> fields" section if nothing else is suitable.
>
>>  /**
>> @@ -518,6 +524,7 @@ struct linereq {
>>  	 GPIO_V2_LINE_DRIVE_FLAGS | \
>>  	 GPIO_V2_LINE_EDGE_FLAGS | \
>>  	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME | \
>> +	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE | \
>>  	 GPIO_V2_LINE_BIAS_FLAGS)
>>  
>>  static void linereq_put_event(struct linereq *lr,
>> @@ -546,6 +553,94 @@ static u64 line_event_timestamp(struct line *line)
>>  	return ktime_get_ns();
>>  }
>>  
>> +static hte_return_t process_hw_ts_thread(void *p)
>> +{
>> +	struct line *line = p;
>> +	struct linereq *lr = line->req;
>> +	struct gpio_v2_line_event le;
>> +	u64 eflags;
>> +
>> +	memset(&le, 0, sizeof(le));
>> +
>> +	le.timestamp_ns = line->timestamp_ns;
>> +	line->timestamp_ns = 0;
>> +
> What is the purpose of this zeroing?
>
>> +	if (line->dir >= HTE_DIR_NOSUPP) {
>> +		eflags = READ_ONCE(line->eflags);
>> +		if (eflags == GPIO_V2_LINE_FLAG_EDGE_BOTH) {
>> +			int level = gpiod_get_value_cansleep(line->desc);
>> +
>> +			if (level)
>> +				/* Emit low-to-high event */
>> +				le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>> +			else
>> +				/* Emit high-to-low event */
>> +				le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_RISING) {
>> +			/* Emit low-to-high event */
>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_FALLING) {
>> +			/* Emit high-to-low event */
>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>> +		} else {
>> +			return HTE_CB_ERROR;
>> +		}
>> +	} else {
>> +		if (line->dir == HTE_RISING_EDGE_TS)
>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>> +		else
>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>> +	}
> The mapping from line->dir to le.id needs to take into account the active
> low setting for the line.
>
> And it might be simpler if the hte_ts_data provided the level, equivalent
> to gpiod_get_raw_value_cansleep(), rather than an edge direction, so you
> can provide a common helper to determine the edge given the raw level.

(So from the level determine the edge?) that sound right specially when

HTE provider has capability to record the edge in that case why bother

getting the level and determine edge?

Calculating the edge from the level makes sense when hte provider does not

have that feature and that is what if (line->dir >= HTE_DIR_NOSUPP) does.

>
>> +
>> +	le.line_seqno = line->line_seqno;
>> +	le.seqno = (lr->num_lines == 1) ? le.line_seqno : line->req_seqno;
>> +	le.offset = gpio_chip_hwgpio(line->desc);
>> +
>> +	linereq_put_event(lr, &le);
>> +
>> +	return HTE_CB_HANDLED;
>> +}
>> +
>> +static hte_return_t process_hw_ts(struct hte_ts_data *ts, void *p)
>> +{
>> +	struct line *line = p;
>> +	struct linereq *lr = line->req;
>> +
>> +	if (!ts)
>> +		return HTE_CB_ERROR;
>> +
>> +	line->timestamp_ns = ts->tsc;
>> +	line->dir = ts->dir;
>> +
> The doc for timestamp_ns states:
>
> 	 * timestamp_ns and req_seqno are accessed only by
> 	 * edge_irq_handler() and edge_irq_thread(), which are themselves
> 	 * mutually exclusive, so no additional protection is necessary.
>
> That no longer holds.  It is now also accessed here, and in
> process_hw_ts_thread(), which wont run concurrently with each other or
> the edge_irq_* handlers, but also in debounce_work_func() which may run
> concurrently with the others.
> So timestamp_ns now requires protection from concurrent access.
>
>> +	/*
>> +	 * It is possible that HTE engine detects spurious edges for the
>> +	 * lines where software debounce is enabled. This primary callback
>> +	 * will be called multiple times in that case. It will be better to
>> +	 * let debounce_work_func handle instead of process_hw_ts_thread.
>> +	 * The timestamp_ns will be overwritten here which is fine as we are
>> +	 * interested in the last value anyway. The debounce_work_func will
>> +	 * then just read whatever last line->timestamp_ns is stored. Because
>> +	 * this callback can be called multiple times, we are not really
>> +	 * interested in ts->seq.
>> +	 */
> Not sure what this is trying to say.
> Is this the primary callback? Or debounce_irq_handler()?

This is primary callback called from HTE when it pushes new TS data per line, it

also says so in the second line.

> You say you really aren't interested in ts->seq, but the code immediately
> uses it.

That is when sw_debounced is not set and whole paragraph is about when

sw_debounced is set.

>
> Reword to clarify.
> And add braces after function names to highlight them, so
> debounce_work_func().
Will do.
>
>> +	if (!READ_ONCE(line->sw_debounced)) {
>> +		line->line_seqno = ts->seq;
>> +
>> +		/*
>> +		 * Increment in this callback incase all the lines in linereq
>> +		 * are enabled for hw timestamping. This will work even if
>> +		 * subset of lines are enabled for hw timestamping as
>> +		 * edge_irq_* callbacks will proceed as usual for them.
>> +		 */
> s/incase/in case/
>
> Not sure what the comment is trying to say. There is no check here that
> the other lines have HTE enabled.  And that is not relevant anyway.
> The edge_irq_* handlers will proceed as usual for those lines NOT
> enabled for hw timestamping.
>
> To clarify, the line_seqno indicates where this event lies in the
> sequence of events for the line.
> The request seqno indicates where this event lines in the sequence of
> events for the request.
> For a single line request these are the same, hence the minor
> optimisation of not updating lr->seqno below.
>
>> +		if (lr->num_lines != 1)
>> +			line->req_seqno = atomic_inc_return(&lr->seqno);
>> +
> The req_seqno should be updated corresponding to the change in the
> line_reqno.  That always used to be 1, but no longer if hte can discard
> events, i.e. skip over line_seqnos.

HTE does not discard any events, it pushes to clients as soon as its

available through primary callback.

> To be consistent, i.e. if events were lost for this line then they were
> also lost for the requested lines, the lr->seqno should be incremented by
> the change in line_seqno.  Probably with some sanity checks.
>
>> +		return HTE_RUN_THREADED_CB;
>> +	}
>> +
>> +	return HTE_CB_HANDLED;
>> +}
>> +
>>  static irqreturn_t edge_irq_thread(int irq, void *p)
>>  {
>>  	struct line *line = p;
>> @@ -553,6 +648,10 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
>>  	struct gpio_v2_line_event le;
>>  	u64 eflags;
>>  
>> +	/* Let process_hw_ts_thread handle */
>> +	if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &line->desc->flags))
>> +		return IRQ_HANDLED;
>> +
> This adds pointless runtime overhead, and for everyone not just hte users.
> Don't stub out a handler in the handler - stub it out where it is
> registered by registering a stub handler.  Or don't request it at all.
>
> So why would gpiolib-cdev be requesting the irq, only to stub out
> the handlers?
> If that has a side-effect that hte requires then hte should be taking
> care of it - it is not gpiolib-cdev's problem.

- Why stop at moving irq and debounce related stuff to hte then?

I mean if there is hte provider which can TS GPIO output/input

does it mean hte is responsible for parsing the GPIO line configs, setting them up

(i.e. input or output) as well? Are we not duplicating logic instead of

leveraging gpio-cdev? Does it make sense for the HTE subsystem which not

only TS the GPIOs but other SoC lines?

- What happens to in kernel GPIO HTE client (for example, hte-tegra194-gpio-test.c)?

some clients do more in their IRQ handler than what edge_irq_handler does in which

case it would make sense to have them request irq in their code than through HTE.

>
> And speaking as to how the whole hte/gpiolib-cdev interface should work,
> hte should be an edge event generator alternative to irq.  So lines with
> hte enabled should work without any irq calls from gpiolib-cdev.
> That includes the sw debouncer - more on that below.
>
>>  	/* Do not leak kernel stack to userspace */
>>  	memset(&le, 0, sizeof(le));
>>  
>> @@ -604,6 +703,10 @@ static irqreturn_t edge_irq_handler(int irq, void *p)
>>  	struct line *line = p;
>>  	struct linereq *lr = line->req;
>>  
>> +	/* Let HTE supplied callbacks handle */
>> +	if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &line->desc->flags))
>> +		return IRQ_HANDLED;
>> +
>>  	/*
>>  	 * Just store the timestamp in hardirq context so we get it as
>>  	 * close in time as possible to the actual event.
>> @@ -682,14 +785,6 @@ static void debounce_work_func(struct work_struct *work)
>>  	/* Do not leak kernel stack to userspace */
>>  	memset(&le, 0, sizeof(le));
>>  
>> -	lr = line->req;
>> -	le.timestamp_ns = line_event_timestamp(line);
>> -	le.offset = gpio_chip_hwgpio(line->desc);
>> -	line->line_seqno++;
>> -	le.line_seqno = line->line_seqno;
>> -	le.seqno = (lr->num_lines == 1) ?
>> -		le.line_seqno : atomic_inc_return(&lr->seqno);
>> -
>>  	if (level)
>>  		/* Emit low-to-high event */
>>  		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>> @@ -697,6 +792,23 @@ static void debounce_work_func(struct work_struct *work)
>>  		/* Emit high-to-low event */
>>  		le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>>  
>> +	if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &line->desc->flags)) {
>> +		le.timestamp_ns = line->timestamp_ns;
>> +		if (line->dir < HTE_DIR_NOSUPP)
>> +			le.id = (line->dir == HTE_RISING_EDGE_TS) ?
>> +				 GPIO_V2_LINE_EVENT_RISING_EDGE :
>> +				 GPIO_V2_LINE_EVENT_FALLING_EDGE;
>> +	} else {
>> +		le.timestamp_ns = line_event_timestamp(line);
>> +	}
>> +
> Move the FLAG_EVENT_CLOCK_HARDWARE check into line_event_timestamp().
>
> And the id fudging is necessary because the level returned by
> gpiod_get_raw_value_cansleep() can disagree with the level from hte?

> So you are still trying to synchronise events from two streams.
> And that is still broken.
> If a hte event occurs between the level being sampled by
> gpiod_get_raw_value_cansleep() and the line->dir being read then the line
> will have toggled and you will be reporting the opposite state than the
> one the debouncer determined was stable.  And maybe the wrong timestamp as
> well.
>
> For lines where hte is enabled, the hte should be the source of level for
> the debouncer, not the raw value.  And the mod_delayed_work() that
> drives the debouncer should be called by a hte handler, not an irq handler.
>
> There is also a race on reading the hte timestamp (line->timestamp_ns) and
> the hte level (line->dir), such that you can get the level from one event
> the timestamp from another.
>
>> +	lr = line->req;
>> +	le.offset = gpio_chip_hwgpio(line->desc);
>> +	line->line_seqno++;
>> +	le.line_seqno = line->line_seqno;
>> +	le.seqno = (lr->num_lines == 1) ?
>> +		le.line_seqno : atomic_inc_return(&lr->seqno);
>> +
> What is the purpose of moving this block of code moved from before the
> if (level)?
>
>
>>  	linereq_put_event(lr, &le);
>>  }
>>  
>> @@ -891,7 +1003,6 @@ static int gpio_v2_line_flags_validate(u64 flags)
>>  	/* Return an error if an unknown flag is set */
>>  	if (flags & ~GPIO_V2_LINE_VALID_FLAGS)
>>  		return -EINVAL;
>> -
> Gratuitous whitespace change.
>
>>  	/*
>>  	 * Do not allow both INPUT and OUTPUT flags to be set as they are
>>  	 * contradictory.
>> @@ -900,6 +1011,11 @@ static int gpio_v2_line_flags_validate(u64 flags)
>>  	    (flags & GPIO_V2_LINE_FLAG_OUTPUT))
>>  		return -EINVAL;
>>  
>> +	/* Only allow one event clock source */
>> +	if ((flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME) &&
>> +	    (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE))
>> +		return -EINVAL;
>> +
>>  	/* Edge detection requires explicit input. */
>>  	if ((flags & GPIO_V2_LINE_EDGE_FLAGS) &&
>>  	    !(flags & GPIO_V2_LINE_FLAG_INPUT))
>> @@ -992,6 +1108,8 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 flags,
>>  
>>  	assign_bit(FLAG_EVENT_CLOCK_REALTIME, flagsp,
>>  		   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME);
>> +	assign_bit(FLAG_EVENT_CLOCK_HARDWARE, flagsp,
>> +		   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE);
>>  }
>>  
>>  static long linereq_get_values(struct linereq *lr, void __user *ip)
>> @@ -1154,6 +1272,21 @@ static long linereq_set_config_unlocked(struct linereq *lr,
>>  				return ret;
>>  		}
>>  
>> +		/* Check if new config sets hardware assisted clock */
>> +		if (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE) {
>> +			ret = gpiod_req_hw_timestamp_ns(desc, process_hw_ts,
>> +							process_hw_ts_thread,
>> +							&lr->lines[i]);
>> +			if (ret)
>> +				return ret;
> Note that the line config is the complete line config, not a delta.
>
> What happens when a line that already has hte enabled is reconfigured
> and still has hte enabled?  i.e. what happens when
> gpiod_req_hw_timestamp_ns() is called for the second time?

HTE will return without doing anything with error code.

>
> You provide a comment for the release case below, what of the request
> case?
>
> If you need to check for change then compare the old and new flags, as
> the polarity_change check does (not visible in the diff here).
>
>> +		} else {
>> +			/*
>> +			 * HTE subsys will do nothing if there is nothing to
>> +			 * release.
>> +			 */
>> +			gpiod_rel_hw_timestamp_ns(desc);
>> +		}
>> +
> Comment will fit on one line.
>
> And it would be better to document that the function is idempotent in the
> function documentation, not everywhere it is used.
>
>>  		blocking_notifier_call_chain(&desc->gdev->notifier,
>>  					     GPIO_V2_LINE_CHANGED_CONFIG,
>>  					     desc);
>> @@ -1409,6 +1542,14 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>>  					flags & GPIO_V2_LINE_EDGE_FLAGS);
>>  			if (ret)
>>  				goto out_free_linereq;
>> +
>> +			if (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE) {
>> +				ret = gpiod_req_hw_timestamp_ns(desc, process_hw_ts,
>> +							process_hw_ts_thread,
>> +							&lr->lines[i]);
>> +				if (ret)
>> +					goto out_free_linereq;
>> +			}
>>  		}
>>  
>>  		blocking_notifier_call_chain(&desc->gdev->notifier,
>> @@ -1959,6 +2100,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
>>  
>>  	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &desc->flags))
>>  		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME;
>> +	else if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &desc->flags))
>> +		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE;
>>  
>>  	debounce_period_us = READ_ONCE(desc->debounce_period_us);
>>  	if (debounce_period_us) {
>> diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
>> index eaaea3d8e6b4..d360545b4c21 100644
>> --- a/include/uapi/linux/gpio.h
>> +++ b/include/uapi/linux/gpio.h
>> @@ -80,6 +80,7 @@ enum gpio_v2_line_flag {
>>  	GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN	= _BITULL(9),
>>  	GPIO_V2_LINE_FLAG_BIAS_DISABLED		= _BITULL(10),
>>  	GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME	= _BITULL(11),
>> +	GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE	= _BITULL(12),
>>  };
>>  
> I'm now thinking this name, "HARDWARE" is too vague, in case other
> timestamp source alternatives join the fray, and so should be "HTE".
>
> Cheers,
> Kent.
