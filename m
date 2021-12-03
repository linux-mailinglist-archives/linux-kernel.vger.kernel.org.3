Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7EE468050
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383459AbhLCX0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:26:07 -0500
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:13920
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1383447AbhLCX0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:26:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9Nbd5oZhFfUWicBFStCtFT61u286P6xx4tQTs9EYMISRPQxoaj71BBPj5MKVazrD2FGtMdXzTA5x/+iEnSna8iQ3kRNpDWXq1RLRsJqkPR6e6oCZPizCuQ1qqDkPnPfPcnZR6t9iBVlhr0MoErqLJ4mclR6Ix5i2/q65g/8GC38rxSybX/0I4rza/DLM+u4Z13edOGja0nVv6mYH4hBCUu4Rcgs3ydAnu+4gnyV/sggKS8dK4e6D+NSt8t5rjstlZ46haE3A/7FHuoZaXCbFqLNUhRVRDqa9h0wEnq5CSsh+aTpXHQtblFvMCwuUAMAFYGfV6VqPBYrBmZWEUO2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+1/P7RFpC2zfPnkUWkwY/CdfdxeofIQMFI7ckUc4xo=;
 b=hJZkKDfQzfJp/HDTRlj2ry3/NFoIn1oSiJqSYJNTOVl6FDkS/G5XWRy0j9wEilsLN+Fro0Te1E7JKFSSPoILuV9aZ3InHaBVOmBaXeyDiFU4TWsG8heeYM5hP6xlD/Wp4WFH7mkmDOrWDjUQhwbrbpH9VA/rTVjs3ZR/U9P+NZqJeKD2KpqA7FOL9C7oC3EgvZ4vNqcjnRC5TwzuGSdMa4Ql6Vqjg2BJjYtllbzPKf0fyKyDWf+ukWd+cfzSZneB1105HKi+i2sLlBvzbQmiAT0qbgZuPy7LmlzrfCVOxRAZzxmXREcUXIFJhIOzniPy2g/ltgkZSAvpwADmSzbYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+1/P7RFpC2zfPnkUWkwY/CdfdxeofIQMFI7ckUc4xo=;
 b=kzCvvdsnXRLThWP5p+BYVgJYgfvhxx8ymh3FTLQiV8VAdJAz7RZEoxvrej1pPat4o4VzCdUG0YpCdSG0ae1L3wHUJHYL5Kn+yY3fPZoU4G4Gc7IjQ1wHS5itMY2uY4+eM+z18vh60A5WXEMbwbcyjcIPehciG6VeKIinnS2xPXr8rmZjQvUN+9mFrgzO/ZYu7huXjYswsX7Jr9TfSgBrsv/iYTjQo8dq8bYeA9IkCcBGZjRcTCYWs82a6l9xDVb3V/X/rZenwhYNdRfPVE8pov+ghhiW8yylQHm+w0/uYbhwyxgnv2fHcUHBsNOKUBUGrHjFJ76QrFBGayNwT68R/w==
Received: from MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::21)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 23:22:37 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::ab) by MW4P223CA0016.outlook.office365.com
 (2603:10b6:303:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Fri, 3 Dec 2021 23:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 23:22:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 3 Dec
 2021 23:22:36 +0000
Received: from [172.17.173.69] (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Fri, 3 Dec 2021
 15:22:35 -0800
Subject: Re: [RFC v3 09/12] gpiolib: cdev: Add hardware timestamp clock type
To:     Kent Gibson <warthog618@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
References: <20211123193039.25154-1-dipenp@nvidia.com>
 <20211123193039.25154-10-dipenp@nvidia.com> <20211126013137.GC10380@sol>
 <9ad666ec-eedd-8075-73e6-1e47a1eb228b@nvidia.com>
 <20211201171638.GA31045@sol>
 <4c7c3db1-a1b3-1944-4278-cb37e8a4f373@nvidia.com> <20211202005349.GA7007@sol>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
Message-ID: <8b6dbb5a-4543-b4dd-b605-d3ea3a5ff9d4@nvidia.com>
Date:   Fri, 3 Dec 2021 15:24:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202005349.GA7007@sol>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65711ab0-d792-4366-a656-08d9b6b3cb2a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4209:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4209DA29660DB8890094C775AE6A9@BY5PR12MB4209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGzxG3WmAFYUcDxytn3gc3Eb7KG8+84Wky2Qg4b7T8JrbEtZi2V1UJCPuvI6d9//OqHtnLokGIDeFbt+qhRB+krZuOuKWg0zY7dty9MS2wT2FXS+eBGylcFo1Hnb+NR/msHrG8e4TOTOidSjwNW/9E1a1AT2Cm/s47qU3pm0cfMbweP99RYBwAq74s1Lbm7BMaocQTJFwvXHKlvRZFNBrhSTay7nw6c69aOTcl0Dt1abFzCE3GItgt9clE4+kHQeRaGvAVEUT666HOfhGLmHC5RDesPKdWOmz81S11exukaLJE3qYMVThAyKSTuoxTgYB4VC0X4lz99M3Io4fuLSvjxaV1KKLJlO74wY/4z21Od2CGD1negn2WJ49TennEaEG2AeGhhvIuyzBzvIpywiqZkDvuOZF3djXXdooBKkIB3ux+b63m+gsGNOWeoariEPAvtigUlwy2bPvyXCb5Xox1+lqeg/80TJeBVweQuAEN7StM2pE0E5Ykx+Wz+dqR6ydHFCzEweg7g3f88ylvf5oQjw1rJq+rzXOU4ShJoFuP3DzetmH8E5lMu4UjDQoNRz7OnTV7m+lRj30x3VOQyAjQ+UVU12e2J5+A8cK5hyKNXXCTL/Bx3f0rBKfvO/HcTt/iQOTZ/mNCTjm+URANNVVzHku31iBji5bZwNvK8tz0H42UXW2Ny/r3/fNk5dQzdueXyZPxsG7hon5ZsL6geU0dWI0++ijXcXwTXssus26t1/Mhv008JUSa/1UU1dCYfznVIpFX5MJ3CUOo8nQmIXubl1x0IPDgppcDf4yaN6Q8Q=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(6916009)(16526019)(26005)(2906002)(70206006)(30864003)(83380400001)(16576012)(54906003)(8936002)(508600001)(426003)(4326008)(316002)(336012)(70586007)(2616005)(5660300002)(36860700001)(186003)(53546011)(31696002)(8676002)(86362001)(47076005)(31686004)(7636003)(82310400004)(356005)(40460700001)(7416002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 23:22:37.2357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65711ab0-d792-4366-a656-08d9b6b3cb2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/1/21 4:53 PM, Kent Gibson wrote:
> On Wed, Dec 01, 2021 at 10:01:46AM -0800, Dipen Patel wrote:
>> Hi,
>>
>>
>> On 12/1/21 9:16 AM, Kent Gibson wrote:
>>> On Tue, Nov 30, 2021 at 07:29:20PM -0800, Dipen Patel wrote:
>>>> Hi,
>>>>
>>>> On 11/25/21 5:31 PM, Kent Gibson wrote:
>>>>> On Tue, Nov 23, 2021 at 11:30:36AM -0800, Dipen Patel wrote:
>>>>>> This patch adds new clock type for the GPIO controller which can
>>>>>> timestamp gpio lines in realtime using hardware means. To expose such
>>>>>> functionalities to the userspace, code has been added in this patch
>>>>>> where during line create call, it checks for new clock type and if
>>>>>> requested, calls hardware timestamp related API from gpiolib.c.
>>>>>> During line change event, the HTE subsystem pushes timestamp data
>>>>>> through callbacks.
>>>>>>
>>>>>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>>>>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> - Added hte_dir and static structure hte_ts_desc.
>>>>>> - Added callbacks which get invoked by HTE when new data is available.
>>>>>> - Better use of hte_dir and seq from hte_ts_desc.
>>>>>> - Modified sw debounce function to accommodate hardware timestamping.
>>>>>>
>>>>>>  drivers/gpio/gpiolib-cdev.c | 161 ++++++++++++++++++++++++++++++++++--
>>>>>>  include/uapi/linux/gpio.h   |   1 +
>>>>>>  2 files changed, 153 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
>>>>>> index c7b5446d01fd..1736ad54e3ec 100644
>>>>>> --- a/drivers/gpio/gpiolib-cdev.c
>>>>>> +++ b/drivers/gpio/gpiolib-cdev.c
>>>>>> @@ -464,6 +464,12 @@ struct line {
>>>>>>  	 * stale value.
>>>>>>  	 */
>>>>>>  	unsigned int level;
>>>>>> +	/*
>>>>>> +	 * dir will be touched in HTE callbacks hte_ts_cb_t and
>>>>>> +	 * hte_ts_threaded_cb_t and they are mutually exclusive. This will be
>>>>>> +	 * unused when HTE is not supported/disabled.
>>>>>> +	 */
>>>>>> +	enum hte_dir dir;
>>>>>>  };
>>>>>>  
>>>>> Documentation should be in present tense, so 
>>>>>
>>>>> s/will be/is/g
>>>>>
>>>>> Same applies to other patches.
>>>>>
>>>>> Also
>>>>>
>>>>> s/touched/accessed/
>>>>>
>>>>> dir is a poor name for the field.  It is the hte edge direction and
>>>>> effectively the line level, so call it hte_edge_dirn or
>>>>> hte_edge_direction or hte_level.
>>>>>
>>>>> And it is placed in a section of the struct documented as "debouncer specific
>>>>> fields", but it is not specfic to the debouncer.  Add a "hte specific
>>>>> fields" section if nothing else is suitable.
>>>>>
>>>>>>  /**
>>>>>> @@ -518,6 +524,7 @@ struct linereq {
>>>>>>  	 GPIO_V2_LINE_DRIVE_FLAGS | \
>>>>>>  	 GPIO_V2_LINE_EDGE_FLAGS | \
>>>>>>  	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME | \
>>>>>> +	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE | \
>>>>>>  	 GPIO_V2_LINE_BIAS_FLAGS)
>>>>>>  
>>>>>>  static void linereq_put_event(struct linereq *lr,
>>>>>> @@ -546,6 +553,94 @@ static u64 line_event_timestamp(struct line *line)
>>>>>>  	return ktime_get_ns();
>>>>>>  }
>>>>>>  
>>>>>> +static hte_return_t process_hw_ts_thread(void *p)
>>>>>> +{
>>>>>> +	struct line *line = p;
>>>>>> +	struct linereq *lr = line->req;
>>>>>> +	struct gpio_v2_line_event le;
>>>>>> +	u64 eflags;
>>>>>> +
>>>>>> +	memset(&le, 0, sizeof(le));
>>>>>> +
>>>>>> +	le.timestamp_ns = line->timestamp_ns;
>>>>>> +	line->timestamp_ns = 0;
>>>>>> +
>>>>> What is the purpose of this zeroing?
>>>>>
>>>>>> +	if (line->dir >= HTE_DIR_NOSUPP) {
>>>>>> +		eflags = READ_ONCE(line->eflags);
>>>>>> +		if (eflags == GPIO_V2_LINE_FLAG_EDGE_BOTH) {
>>>>>> +			int level = gpiod_get_value_cansleep(line->desc);
>>>>>> +
>>>>>> +			if (level)
>>>>>> +				/* Emit low-to-high event */
>>>>>> +				le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>>>>>> +			else
>>>>>> +				/* Emit high-to-low event */
>>>>>> +				le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>>>>>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_RISING) {
>>>>>> +			/* Emit low-to-high event */
>>>>>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>>>>>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_FALLING) {
>>>>>> +			/* Emit high-to-low event */
>>>>>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>>>>>> +		} else {
>>>>>> +			return HTE_CB_ERROR;
>>>>>> +		}
>>>>>> +	} else {
>>>>>> +		if (line->dir == HTE_RISING_EDGE_TS)
>>>>>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>>>>>> +		else
>>>>>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>>>>>> +	}
>>>>> The mapping from line->dir to le.id needs to take into account the active
>>>>> low setting for the line.
>>>>>
>>>>> And it might be simpler if the hte_ts_data provided the level, equivalent
>>>>> to gpiod_get_raw_value_cansleep(), rather than an edge direction, so you
>>>>> can provide a common helper to determine the edge given the raw level.
>>>> (So from the level determine the edge?) that sound right specially when
>>>>
>>>> HTE provider has capability to record the edge in that case why bother
>>>>
>>>> getting the level and determine edge?
>>>>
>>>> Calculating the edge from the level makes sense when hte provider does not
>>>>
>>>> have that feature and that is what if (line->dir >= HTE_DIR_NOSUPP) does.
>>>>
>>> As asked in the review of patch 02, do you have an example of hardware that
>>> reports an edge direction rather than NOSUPP?
>> No...
> So you are adding an interface that nothing will currently use.
> Are there plans for hardware that will report the edge, and you are
> laying the groundwork here?
>
>>> Anyway, this is just a naming thing - the information content being passed
>>> is the the same, be it high/low/unknown or rising/falling/unknown.
>>>
>>> If the hardware does report edge direction then it is just one bit, and
>>> that also corresponds to the physical level immediately following the
>>> edge, so no additional conversion required there.
>>>
>>> It would be clearer to pass a level than an edge, as
>>>  - a hte edge (hte_dir) could be confused with a cdev edge
>>>    (gpio_v2_line_event_id), in mails like this if not in the code.
>>>  - cdev will fallback to using the physical level to determine the edge
>>>    if the hte can't provide it
>> I believe I have retained all the fallback logic in such case.
>>>  - cdev has to perform inversion if active low and it already does that
>>>    based on levels
>>>
>>>>>> +
>>>>>> +	le.line_seqno = line->line_seqno;
>>>>>> +	le.seqno = (lr->num_lines == 1) ? le.line_seqno : line->req_seqno;
>>>>>> +	le.offset = gpio_chip_hwgpio(line->desc);
>>>>>> +
>>>>>> +	linereq_put_event(lr, &le);
>>>>>> +
>>>>>> +	return HTE_CB_HANDLED;
>>>>>> +}
>>>>>> +
>>>>>> +static hte_return_t process_hw_ts(struct hte_ts_data *ts, void *p)
>>>>>> +{
>>>>>> +	struct line *line = p;
>>>>>> +	struct linereq *lr = line->req;
>>>>>> +
>>>>>> +	if (!ts)
>>>>>> +		return HTE_CB_ERROR;
>>>>>> +
>>>>>> +	line->timestamp_ns = ts->tsc;
>>>>>> +	line->dir = ts->dir;
>>>>>> +
>>>>> The doc for timestamp_ns states:
>>>>>
>>>>> 	 * timestamp_ns and req_seqno are accessed only by
>>>>> 	 * edge_irq_handler() and edge_irq_thread(), which are themselves
>>>>> 	 * mutually exclusive, so no additional protection is necessary.
>>>>>
>>>>> That no longer holds.  It is now also accessed here, and in
>>>>> process_hw_ts_thread(), which wont run concurrently with each other or
>>>>> the edge_irq_* handlers, but also in debounce_work_func() which may run
>>>>> concurrently with the others.
>>>>> So timestamp_ns now requires protection from concurrent access.
>>>>>
>>>>>> +	/*
>>>>>> +	 * It is possible that HTE engine detects spurious edges for the
>>>>>> +	 * lines where software debounce is enabled. This primary callback
>>>>>> +	 * will be called multiple times in that case. It will be better to
>>>>>> +	 * let debounce_work_func handle instead of process_hw_ts_thread.
>>>>>> +	 * The timestamp_ns will be overwritten here which is fine as we are
>>>>>> +	 * interested in the last value anyway. The debounce_work_func will
>>>>>> +	 * then just read whatever last line->timestamp_ns is stored. Because
>>>>>> +	 * this callback can be called multiple times, we are not really
>>>>>> +	 * interested in ts->seq.
>>>>>> +	 */
>>>>> Not sure what this is trying to say.
>>>>> Is this the primary callback? Or debounce_irq_handler()?
>>>> This is primary callback called from HTE when it pushes new TS data per line, it
>>>>
>>>> also says so in the second line.
>>>>
>>> Yeah, I probably read that as "The primary callback", but it is
>>> confusing anyway. "This primary callback" implies there is another
>>> primary callback. 
>>> Just say "This handler" instead of "This primary callback".
>> Noted...
>>>>> You say you really aren't interested in ts->seq, but the code immediately
>>>>> uses it.
>>>> That is when sw_debounced is not set and whole paragraph is about when
>>>>
>>>> sw_debounced is set.
>>>>
>>> So your whole comment here is about the else case?
>>> Then either put the comment where the else would be, or better yet invert
>>> the logic and return immediately if sw_debounced.
>> Sure...
> Understand, you wont be maintaining this code, even if you intend to.
> Consider the poor unfortunate who will have to deal with your code in
> the future.  This is not and should not be a minor consideration.
>
> Sometimes long winded comments only add confusion rather than clarity.
> If the code alone is confusing and requires more than a line or two of
> explanatory comments, excluding function documentation, then you might
> want to rethink your code.
>
> In this case the clearest is probably to restructure the if condition as
> I suggested and simplify or even drop the comment.
Agreed...
>
>>>>> Reword to clarify.
>>>>> And add braces after function names to highlight them, so
>>>>> debounce_work_func().
>>>> Will do.
>>>>>> +	if (!READ_ONCE(line->sw_debounced)) {
>>>>>> +		line->line_seqno = ts->seq;
>>>>>> +
>>>>>> +		/*
>>>>>> +		 * Increment in this callback incase all the lines in linereq
>>>>>> +		 * are enabled for hw timestamping. This will work even if
>>>>>> +		 * subset of lines are enabled for hw timestamping as
>>>>>> +		 * edge_irq_* callbacks will proceed as usual for them.
>>>>>> +		 */
>>>>> s/incase/in case/
>>>>>
>>>>> Not sure what the comment is trying to say. There is no check here that
>>>>> the other lines have HTE enabled.  And that is not relevant anyway.
>>>>> The edge_irq_* handlers will proceed as usual for those lines NOT
>>>>> enabled for hw timestamping.
>>>>>
>>>>> To clarify, the line_seqno indicates where this event lies in the
>>>>> sequence of events for the line.
>>>>> The request seqno indicates where this event lines in the sequence of
>>>>> events for the request.
>>>>> For a single line request these are the same, hence the minor
>>>>> optimisation of not updating lr->seqno below.
>>>>>
>>>>>> +		if (lr->num_lines != 1)
>>>>>> +			line->req_seqno = atomic_inc_return(&lr->seqno);
>>>>>> +
>>>>> The req_seqno should be updated corresponding to the change in the
>>>>> line_reqno.  That always used to be 1, but no longer if hte can discard
>>>>> events, i.e. skip over line_seqnos.
>>>> HTE does not discard any events, it pushes to clients as soon as its
>>>>
>>>> available through primary callback.
>>> The discarding of events that I am referring to is from your previous
>>> answers that indicated, to me anyway, that there could be gaps in the
>>> ts->seq numbers if the hardware event FIFO overflowed.
>>> Is that not the case?
>> Not in this patch series as the provider I have dealt with does not such
>>
>> feature. ts->seq is software counter in that case.
>>
> The code here has to deal with the general case, not just the one example
> driver you have provided.  So in general there COULD be gaps in the
> ts->seq, right?

Good point. I agree for the general case and also agree that it could have gap when such

providers exist. I will revisit this logic in next version 4.

>
> I do see that using the ts-seq for sw debounced lines is problematic
> though. The debouncer itself will be discarding hte events, but that
> shouldn't be considered a lost event to the user.  You could track
> how many events are discarded by the debouncer and subtract those from
> the sequence numbers reported to userspace?
I agree, I will correct the logic in next version 4.
>
>>> And when you say "primary callback", both here and elsewhere, you mean the
>>> cb parameter to gpiod_req_hw_timestamp_ns() and gc->req_hw_timestamp()?
>> yes, cb is primary and tcb (threaded cb) is optional secondary.
>>> Either way, be specific and name the function or parameter, or find a
>>> better term than "primary callback".
>>> In this case "the client's event handler" would be much clearer.
>> Noted...
>>>>> To be consistent, i.e. if events were lost for this line then they were
>>>>> also lost for the requested lines, the lr->seqno should be incremented by
>>>>> the change in line_seqno.  Probably with some sanity checks.
>>>>>
>>>>>> +		return HTE_RUN_THREADED_CB;
>>>>>> +	}
>>>>>> +
>>>>>> +	return HTE_CB_HANDLED;
>>>>>> +}
>>>>>> +
>>>>>>  static irqreturn_t edge_irq_thread(int irq, void *p)
>>>>>>  {
>>>>>>  	struct line *line = p;
>>>>>> @@ -553,6 +648,10 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
>>>>>>  	struct gpio_v2_line_event le;
>>>>>>  	u64 eflags;
>>>>>>  
>>>>>> +	/* Let process_hw_ts_thread handle */
>>>>>> +	if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &line->desc->flags))
>>>>>> +		return IRQ_HANDLED;
>>>>>> +
>>>>> This adds pointless runtime overhead, and for everyone not just hte users.
>>>>> Don't stub out a handler in the handler - stub it out where it is
>>>>> registered by registering a stub handler.  Or don't request it at all.
>>>>>
>>>>> So why would gpiolib-cdev be requesting the irq, only to stub out
>>>>> the handlers?
>>>>> If that has a side-effect that hte requires then hte should be taking
>>>>> care of it - it is not gpiolib-cdev's problem.
>>>> - Why stop at moving irq and debounce related stuff to hte then?
>>>>
>>> How about you answer my question before asking your own?
>>> Here I am only questioning why gpiolib-cdev is requesting an interrupt
>>> for a hte line at all.  It has no reason to, so hte must have?
>> Commented below in "separation of concern" paragraph.
>>
>>> And where did I suggest moving the "debounce stuff" to hte?
>> Perhaps I misunderstood "That includes the sw debouncer - more on that
>>
>> below." comment.
>>
> The point I was trying to make there was that, for hte enabled lines, the
> sw debouncer should be driven by hte events, not irq events.
> That does not imply nor require moving the debouncer to hte.
Agreed...
>
>>> What I am suggesting is called separation of concerns.  In this context
>>> the intent is to look towards abstracting the edge event generation.
>>> Having hte and irq entangled for no apparent reason makes doing that more
>> But in this patch series (i.e. HTE provider), they are entangled as hte provider
>>
>> will only ts the GPIO line which is configured as input irq. That is why I have
>>
>> separated GPIO line config part and TS part. In other words, let cdev handle
>>
>> any line config that userspace has asked and let hte handle ts part if the
>>
>> line config is supported (If line config is not suitable, it will not enable hte, see
>>
>> gpio-tegra186.c function tegra186_gpio_req_hw_ts() in this patch series where
>>
>> check happens for the tegra hte provider).
>>
> Can you explain "hte provider will only ts the GPIO line which is
> configured as input irq"?

This specific HTE provider hardware is designed to detect edges to ts only on

input lines and which also has IRQ enabled. So for an example, if

userspace requests both OUTPUT and hardware clock config on a line

HTE provider will not generate any TS event on them.

>   That sounds like a hte concern to me, or even
> worse a particular hte provider problem.
>
> The user requests a line with edge event detection enabled and with hte
> timestamps.
> Nothing in that requires irq from gpiolib-cdev.
> gpiolib-cdev should use hte as the event source where it would usually
> use irq. If hte requires irq to allow it to generate those events then
> hte should be responsible for requesting the irq.
> In a hypothetical extreme case where gpiolib-cdev only supported hte
> lines there should be no reference to irq in gpiolib-cdev.
> Yet you continue to insist that gpiolib-cdev should request the irq for
> hte.
> What am I missing here?

I have to be clear, I am not insisting anything here. I am only trying

to understand what else could fall into HTE's plate so that I can get it right.

I am agreeing everything in above comment. I will revisit this logic in next

revision 4.


>
>>> difficult than it needs to be, whereas keeping them separate greatly
>>> simplifies identification of common code suitable for refactoring
>>> subsequently.
>>>
>>> Not sure what to call what you are suggesting.
>>>
>>>> I mean if there is hte provider which can TS GPIO output/input
>>>>
>>>> does it mean hte is responsible for parsing the GPIO line configs, setting them up
>>>>
>>>> (i.e. input or output) as well? Are we not duplicating logic instead of
>>>>
>>>> leveraging gpio-cdev? Does it make sense for the HTE subsystem which not
>>>>
>>>> only TS the GPIOs but other SoC lines?
>>>>
>>>> - What happens to in kernel GPIO HTE client (for example, hte-tegra194-gpio-test.c)?
>>>>
>>>> some clients do more in their IRQ handler than what edge_irq_handler does in which
>>>>
>>>> case it would make sense to have them request irq in their code than through HTE.
>>>>
>>>>> And speaking as to how the whole hte/gpiolib-cdev interface should work,
>>>>> hte should be an edge event generator alternative to irq.  So lines with
>>>>> hte enabled should work without any irq calls from gpiolib-cdev.
>>>>> That includes the sw debouncer - more on that below.
>>>>>
>>>>>>  	/* Do not leak kernel stack to userspace */
>>>>>>  	memset(&le, 0, sizeof(le));
>>>>>>  
>>>>>> @@ -604,6 +703,10 @@ static irqreturn_t edge_irq_handler(int irq, void *p)
>>>>>>  	struct line *line = p;
>>>>>>  	struct linereq *lr = line->req;
>>>>>>  
>>>>>> +	/* Let HTE supplied callbacks handle */
>>>>>> +	if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &line->desc->flags))
>>>>>> +		return IRQ_HANDLED;
>>>>>> +
>>>>>>  	/*
>>>>>>  	 * Just store the timestamp in hardirq context so we get it as
>>>>>>  	 * close in time as possible to the actual event.
>>>>>> @@ -682,14 +785,6 @@ static void debounce_work_func(struct work_struct *work)
>>>>>>  	/* Do not leak kernel stack to userspace */
>>>>>>  	memset(&le, 0, sizeof(le));
>>>>>>  
>>>>>> -	lr = line->req;
>>>>>> -	le.timestamp_ns = line_event_timestamp(line);
>>>>>> -	le.offset = gpio_chip_hwgpio(line->desc);
>>>>>> -	line->line_seqno++;
>>>>>> -	le.line_seqno = line->line_seqno;
>>>>>> -	le.seqno = (lr->num_lines == 1) ?
>>>>>> -		le.line_seqno : atomic_inc_return(&lr->seqno);
>>>>>> -
>>>>>>  	if (level)
>>>>>>  		/* Emit low-to-high event */
>>>>>>  		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>>>>>> @@ -697,6 +792,23 @@ static void debounce_work_func(struct work_struct *work)
>>>>>>  		/* Emit high-to-low event */
>>>>>>  		le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>>>>>>  
>>>>>> +	if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &line->desc->flags)) {
>>>>>> +		le.timestamp_ns = line->timestamp_ns;
>>>>>> +		if (line->dir < HTE_DIR_NOSUPP)
>>>>>> +			le.id = (line->dir == HTE_RISING_EDGE_TS) ?
>>>>>> +				 GPIO_V2_LINE_EVENT_RISING_EDGE :
>>>>>> +				 GPIO_V2_LINE_EVENT_FALLING_EDGE;
>>>>>> +	} else {
>>>>>> +		le.timestamp_ns = line_event_timestamp(line);
>>>>>> +	}
>>>>>> +
>>>>> Move the FLAG_EVENT_CLOCK_HARDWARE check into line_event_timestamp().
>>>>>
>>>>> And the id fudging is necessary because the level returned by
>>>>> gpiod_get_raw_value_cansleep() can disagree with the level from hte?
>>>>> So you are still trying to synchronise events from two streams.
>>>>> And that is still broken.
>>>>> If a hte event occurs between the level being sampled by
>>>>> gpiod_get_raw_value_cansleep() and the line->dir being read then the line
>>>>> will have toggled and you will be reporting the opposite state than the
>>>>> one the debouncer determined was stable.  And maybe the wrong timestamp as
>>>>> well.
>>>>>
>>>>> For lines where hte is enabled, the hte should be the source of level for
>>>>> the debouncer, not the raw value.  And the mod_delayed_work() that
>>>>> drives the debouncer should be called by a hte handler, not an irq handler.
>>>>>
>>>>> There is also a race on reading the hte timestamp (line->timestamp_ns) and
>>>>> the hte level (line->dir), such that you can get the level from one event
>>>>> the timestamp from another.
>>>>>
>>>>>> +	lr = line->req;
>>>>>> +	le.offset = gpio_chip_hwgpio(line->desc);
>>>>>> +	line->line_seqno++;
>>>>>> +	le.line_seqno = line->line_seqno;
>>>>>> +	le.seqno = (lr->num_lines == 1) ?
>>>>>> +		le.line_seqno : atomic_inc_return(&lr->seqno);
>>>>>> +
>>>>> What is the purpose of moving this block of code moved from before the
>>>>> if (level)?
>>>>>
>>>>>
>>>>>>  	linereq_put_event(lr, &le);
>>>>>>  }
>>>>>>  
>>>>>> @@ -891,7 +1003,6 @@ static int gpio_v2_line_flags_validate(u64 flags)
>>>>>>  	/* Return an error if an unknown flag is set */
>>>>>>  	if (flags & ~GPIO_V2_LINE_VALID_FLAGS)
>>>>>>  		return -EINVAL;
>>>>>> -
>>>>> Gratuitous whitespace change.
>>>>>
>>>>>>  	/*
>>>>>>  	 * Do not allow both INPUT and OUTPUT flags to be set as they are
>>>>>>  	 * contradictory.
>>>>>> @@ -900,6 +1011,11 @@ static int gpio_v2_line_flags_validate(u64 flags)
>>>>>>  	    (flags & GPIO_V2_LINE_FLAG_OUTPUT))
>>>>>>  		return -EINVAL;
>>>>>>  
>>>>>> +	/* Only allow one event clock source */
>>>>>> +	if ((flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME) &&
>>>>>> +	    (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE))
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>>  	/* Edge detection requires explicit input. */
>>>>>>  	if ((flags & GPIO_V2_LINE_EDGE_FLAGS) &&
>>>>>>  	    !(flags & GPIO_V2_LINE_FLAG_INPUT))
>>>>>> @@ -992,6 +1108,8 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 flags,
>>>>>>  
>>>>>>  	assign_bit(FLAG_EVENT_CLOCK_REALTIME, flagsp,
>>>>>>  		   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME);
>>>>>> +	assign_bit(FLAG_EVENT_CLOCK_HARDWARE, flagsp,
>>>>>> +		   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE);
>>>>>>  }
>>>>>>  
>>>>>>  static long linereq_get_values(struct linereq *lr, void __user *ip)
>>>>>> @@ -1154,6 +1272,21 @@ static long linereq_set_config_unlocked(struct linereq *lr,
>>>>>>  				return ret;
>>>>>>  		}
>>>>>>  
>>>>>> +		/* Check if new config sets hardware assisted clock */
>>>>>> +		if (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE) {
>>>>>> +			ret = gpiod_req_hw_timestamp_ns(desc, process_hw_ts,
>>>>>> +							process_hw_ts_thread,
>>>>>> +							&lr->lines[i]);
>>>>>> +			if (ret)
>>>>>> +				return ret;
>>>>> Note that the line config is the complete line config, not a delta.
>>>>>
>>>>> What happens when a line that already has hte enabled is reconfigured
>>>>> and still has hte enabled?  i.e. what happens when
>>>>> gpiod_req_hw_timestamp_ns() is called for the second time?
>>>> HTE will return without doing anything with error code.
>>>>
>>> But this is not an error case, it is a normal reconfigure of an
>>> attribute other than the hte flag.
>> I assumed when this function is called it will "reset" and not  update the configs.
>>
>> If this assumption is wrong, I will correct the logic here.
>>
> The set_config does whatever is required to change the line request
> config from the old to the new.  Both old and new are complete snapshots
> of the line request config.
>
> The change should be seamless except for the attributes being changed.
> We certainly do not reset the config and start from scratch - that would
> be little better than the user releasing and re-requesting the lines.
>
> For many attributes we can just apply the new config.  But some cases,
> such as a change to active low polarity, are a lot more involved.
> And if hte considers re-requesting the line to be an error then you
> should only make the hte request when the hte flag changes to set.
Thanks for the explanation, will correct it in next version 4.
>
> Cheers,
> Kent.
>
>>> And that will now return an error to userspace?
>>>
>>> Cheers,
>>> Kent.
>>>
>>>>> You provide a comment for the release case below, what of the request
>>>>> case?
>>>>>
>>>>> If you need to check for change then compare the old and new flags, as
>>>>> the polarity_change check does (not visible in the diff here).
>>>>>
>>>>>> +		} else {
>>>>>> +			/*
>>>>>> +			 * HTE subsys will do nothing if there is nothing to
>>>>>> +			 * release.
>>>>>> +			 */
>>>>>> +			gpiod_rel_hw_timestamp_ns(desc);
>>>>>> +		}
>>>>>> +
>>>>> Comment will fit on one line.
>>>>>
>>>>> And it would be better to document that the function is idempotent in the
>>>>> function documentation, not everywhere it is used.
>>>>>
>>>>>>  		blocking_notifier_call_chain(&desc->gdev->notifier,
>>>>>>  					     GPIO_V2_LINE_CHANGED_CONFIG,
>>>>>>  					     desc);
>>>>>> @@ -1409,6 +1542,14 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>>>>>>  					flags & GPIO_V2_LINE_EDGE_FLAGS);
>>>>>>  			if (ret)
>>>>>>  				goto out_free_linereq;
>>>>>> +
>>>>>> +			if (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE) {
>>>>>> +				ret = gpiod_req_hw_timestamp_ns(desc, process_hw_ts,
>>>>>> +							process_hw_ts_thread,
>>>>>> +							&lr->lines[i]);
>>>>>> +				if (ret)
>>>>>> +					goto out_free_linereq;
>>>>>> +			}
>>>>>>  		}
>>>>>>  
>>>>>>  		blocking_notifier_call_chain(&desc->gdev->notifier,
>>>>>> @@ -1959,6 +2100,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
>>>>>>  
>>>>>>  	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &desc->flags))
>>>>>>  		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME;
>>>>>> +	else if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &desc->flags))
>>>>>> +		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE;
>>>>>>  
>>>>>>  	debounce_period_us = READ_ONCE(desc->debounce_period_us);
>>>>>>  	if (debounce_period_us) {
>>>>>> diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
>>>>>> index eaaea3d8e6b4..d360545b4c21 100644
>>>>>> --- a/include/uapi/linux/gpio.h
>>>>>> +++ b/include/uapi/linux/gpio.h
>>>>>> @@ -80,6 +80,7 @@ enum gpio_v2_line_flag {
>>>>>>  	GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN	= _BITULL(9),
>>>>>>  	GPIO_V2_LINE_FLAG_BIAS_DISABLED		= _BITULL(10),
>>>>>>  	GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME	= _BITULL(11),
>>>>>> +	GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE	= _BITULL(12),
>>>>>>  };
>>>>>>  
>>>>> I'm now thinking this name, "HARDWARE" is too vague, in case other
>>>>> timestamp source alternatives join the fray, and so should be "HTE".
>>>>>
>>>>> Cheers,
>>>>> Kent.
