Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BA350D628
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 02:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiDYAeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 20:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiDYAem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 20:34:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC29BCA3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 17:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650846699; x=1682382699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wDLCtuBq54UtBmgKxE3AVpjC3YNcL/Oi5cNMLBrmOHw=;
  b=jbd65jvnSjI0AJMwzrRNGgS8slHdqsJOIKLO7M1unwSmERPud7tsipq2
   V2m6wwjCDHr2SsJZxnOoGtUKr0lf4/s2+gxqySMhYdRRtQlI4E8aVkGOc
   1wMS3xWNMLdQEo9FJZpyn67/utftJLXqiSa2zmB+4jEaWr2eHRReTGKlG
   JsVQwPunt1NuZlodYx5YoiV6cNfIyDsg8d/MBiZ9Q1KvxXy2v2vGENsp9
   WvoMqQKSep0MUkPyv8yo5rnNJ6RMDS6mHjm/QjIrnAQIG1R4p82kiZ4W7
   8+Vr+XO2y0jRqhlw/KI5YMmLFTkV1LJDQNV83rEXxCJZKCN+5SP6KEj6q
   A==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="198702953"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 08:31:34 +0800
IronPort-SDR: aOAOyHJR8kePLtbl4KCbbVnVFfxn/ols6/ghN3Hg8gDvwyqtMMvDFNdA7KteUCwsEfdgR2m5N6
 95Q5TZdilLdtSak+jAV6SwAnjKwGfHrHtZzLAr0+puSU8L4HltEfEG6+Y7ABTacVAMDKt10KO6
 cSXqLsz7U/zcEAYU8BtaYR165LMhwKbQUI/rCFovRU1EU4Z0qpnVsYUHNZWxyZD5WxKUBsRtX6
 sAchKEhGTdRgBh28k505pLrHTrFT4cbia33kooiuTM24K2d+tJjkxB8u0TSCN97ZAyW0FGL+Xl
 rztJsq+Jl9QLhInm0IIsM/A+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:02:32 -0700
IronPort-SDR: vTXj5YN4oH7chAa6S6OEzDc5BtJ9g0FfjaZCBE6TIP62/OsJhlRz0HyjgOo3OEJkGEJTiGDLDr
 GgBh6v2DEwQlT/obzSK1F7anKD6F006giRBYW5pW4Hq+X/n1sFxwlwgTw8XaLeACZRlcfswXnS
 QcwZ0BEZwKIFQoNYM8S+o8oIpXZmhSzS8OcuIaI+JtCrtE8syK4ZurqJknMX41RQXnW7W4Dhfb
 SE8cUReUo8u1Qp6vm5stVjWXLSw40iG93YL2AtawB1faH+QB2G+3hLt6kSNKj3732uXgINsGw5
 3J4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:31:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmmCq5NmYz1SVny
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 17:31:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650846695; x=1653438696; bh=wDLCtuBq54UtBmgKxE3AVpjC3YNcL/Oi5cN
        MLBrmOHw=; b=DoR0uPeWt/xyFkliUhyDW6DvSryy9Y0bFXtAuH43ROxKkB+uFe+
        9bZwDj6G8CS4bmj72fzJUoFXK6OtCQBpIQ/B0hXBd8RC4mrcI+ymFciCT4N9W5Mz
        lkSRRrKUz+8IrazPZndLAXxqvVZOQD6atFczyNyLlz9UgY+Y1moTWYkqyUehvR7Y
        HMF9A/ko+2pERO/OgxIFHjE2Hbq7HIeOSEn+8R5Eckn7uepMs/qtywX7wPfmz301
        ipUKn1MNGlZRWqfEi4GwRlZrXheKsgLRgzApLgFlJCHc9XcGtwcIy5Q+VpqpzGcr
        cEeMjsO9Rr/wrmaXlpWq/x2sijXj1OlYsBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tMLpuoNHvdEM for <linux-kernel@vger.kernel.org>;
        Sun, 24 Apr 2022 17:31:35 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmmCp0wCwz1Rvlx;
        Sun, 24 Apr 2022 17:31:33 -0700 (PDT)
Message-ID: <983b5717-0993-cb5e-cc21-71efbcd8f636@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 09:31:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] Documentation: drop more IDE boot options and ide-cd.rst
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Phillip Potter <phil@philpotter.co.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220424033701.7988-1-rdunlap@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220424033701.7988-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/22 12:37, Randy Dunlap wrote:
> Drop ide-* command line options.
> Drop cdrom/ide-cd.rst documentation.
> 
> Fixes: 898ee22c32be ("Drop Documentation/ide/")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
> I missed a few things in dropping all IDE documentation.
> Hopefully this is all of the remaining pieces.
> 
>  Documentation/admin-guide/kernel-parameters.txt |   20 
>  Documentation/cdrom/ide-cd.rst                  |  538 --------------
>  2 files changed, 558 deletions(-)

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
