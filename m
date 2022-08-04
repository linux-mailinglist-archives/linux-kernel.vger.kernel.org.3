Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C654F589A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbiHDJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbiHDJvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:51:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497A26AE5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659606699; x=1691142699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1mAFulNWoLFTDJufnr4AN2fWHLLvDVf708xkkVeQJ1E=;
  b=M+/3U3Ovfr9OCwTzG146hQeYzhjcBldufqZndJW83LTxYvNOyrQ5mkgV
   eMcABYYeo4EyebC1WrKkiBF0SBrjS4CiEGzMBRe27jJGLReCLa2ZVEJh7
   gMpj69cIbByFFq7t7dkHPUvCtzJ4ZvZZqdRzVrC+X2cts3LXrA6gJ+R90
   KQU9kiHi4YCUSQa5EXmHpGZTEzwSs/VT6mLoej16XrMLtLu2ezxDomEMX
   XhU2DoFVpQQ2w20RlqHzAi7KLFS8QyP7olL5jmTk5hy4VvtW9VcZix7g5
   wzRp1edxGMeRGVpSU21ZjdCIBYjCro6HjIQZDfmqQtNtTCSmz2uxnWCOF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="272939370"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="272939370"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 02:51:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="745405452"
Received: from mpcastil-mobl2.amr.corp.intel.com (HELO [10.249.40.52]) ([10.249.40.52])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 02:51:34 -0700
Message-ID: <43ada0d7-f094-7f63-3717-30c64834edd6@linux.intel.com>
Date:   Thu, 4 Aug 2022 11:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH resend] ASoC: SOF: ipc3-topology: Fix clang -Wformat
 warning
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>, alsa-devel@alsa-project.org,
        llvm@lists.linux.dev, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Tom Rix <trix@redhat.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20220803204442.2996580-1-justinstitt@google.com>
 <Yure82N7/4NLEMsW@dev-arch.thelio-3990X>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Yure82N7/4NLEMsW@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/22 15:47, Nathan Chancellor wrote:
> On Wed, Aug 03, 2022 at 01:44:42PM -0700, Justin Stitt wrote:
>> When building with Clang we encounter these warnings:
>> | sound/soc/sof/ipc3-topology.c:2343:4: error: format specifies type
>> | 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
>> |                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>> |                  ^~~~~~~~~~~~~~~^~~~~~~~~~~~~~~^~~~~~~~~~~~~
>>
>> Use correct format specifier `%d` since args are of type int.
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/378
>> Reported-by: Nathan Chancellor <nathan@kernel.org>
>> Suggested-by: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Thanks for resending!
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
>> ---
>> Note: resending with the subject corrected, this patch fixes a build
>> warning that will break the Clang build when CONFIG_WERROR=y.
>>
>> Original patch: https://lore.kernel.org/all/20220721211218.4039288-1-justinstitt@google.com/
>> Reported by Nathan here: https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/
>>
>>  sound/soc/sof/ipc3-topology.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
>> index b2cc046b9f60..65923e7a5976 100644
>> --- a/sound/soc/sof/ipc3-topology.c
>> +++ b/sound/soc/sof/ipc3-topology.c
>> @@ -2338,7 +2338,7 @@ static int sof_ipc3_parse_manifest(struct snd_soc_component *scomp, int index,
>>  	}
>>  
>>  	dev_info(scomp->dev,
>> -		 "Topology: ABI %d:%d:%d Kernel ABI %hhu:%hhu:%hhu\n",
>> +		 "Topology: ABI %d:%d:%d Kernel ABI %d:%d:%d\n",
>>  		 man->priv.data[0], man->priv.data[1], man->priv.data[2],
>>  		 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>>  
>> -- 
>> 2.37.1.359.gd136c6c3e2-goog
>>
