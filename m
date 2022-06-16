Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6844A54D609
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbiFPAYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347220AbiFPAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:23:35 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEC61F2D8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655339015; x=1686875015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zZ9XlC7/d8yGFVGGImcAjZu6pedLsVXV7Ze6hqnSWA8=;
  b=grHp2xL9hoSZMPy7TRqMFnB5MdkHXA4/zS0IIkE58ucrx7k/9vJaQQ9o
   74sp/KojgIuLNtVoeG73TAN/riT1f6GU2svrjrCdG3VNA/sl/UElIpHZn
   jGCv1wyYQFvpg2OKiUw/3jDw6F6I66gSfiwgZKLyYoufKWxaZUnC0/8OL
   Nu+m+K0Qv/X3f5lWulo6E2/DV6fGgriLetd1mZZKyNY1Sy/TrpJX8mlYR
   L239HQKMG54HTAv6W+n709NSQJyrMcry+pGzWY/5ECr0bAZzoSchWR4K5
   oCVVTFnHaeYbid3kk2bsrx2L+VP2PXW/gl4wrmAaQRO0ZzEIYRolKL1dX
   A==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="204038063"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 08:23:33 +0800
IronPort-SDR: yKHBdykJS8cE/gHmO8vawlE4qOKOD11ZMgi8l9HgJGIiOErlQpiS/WbbWa0K28owapGB+HQ9cF
 7DURQizwIfvGErdPAXhBRPxJ0VVlYgR/97rWcQaBgYEedozbMzDGfqT0DNX3uqxBYDp9H/S6W7
 lnCKfG1R1Sp8m/ECq9ADEXEd89nAET7ideI+dv3BtME5WXJLGwMcUXgies+R8EsZviTq7SkG5U
 /+4OgoSvgNVPOaro+rfh0K2BZ1Ww8iQ8PyHJrADbEK0DR9JtRa/gppM85TmIBx1/u2IqTOxK3Y
 889Cqb6pjyVZJk5MU8ABzMst
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 16:41:56 -0700
IronPort-SDR: GWxNxY1xDj5O+reACcUJUlLDOtQ47w3Bn/ieqQKHWASogK+WRnycnnI5OJg1jIeaFntjDENoTR
 Hl7QMbqUFqgZj0hBEmfwxE6cg3Zy6u0WRB2wCUSzZPfI0K3DCRnc+b47ZHUxrhDhMkOXlyLonP
 RSjEV+MeEFrwriWCnrgDmOuN+TeVVbtmtnx9c5AvyHh5dLmArii9UycIzVjOx3dLGxn+o5N0XS
 xWvxClap6XzWO3S1uB1hDY6BZGhpYG7x/81see3r/3sNZcd4j3MV4d8upULwyG/8C52WYDyoId
 ucY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 17:23:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNjZW5z3Zz1SVp2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:23:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655339011; x=1657931012; bh=zZ9XlC7/d8yGFVGGImcAjZu6pedLsVXV7Ze
        6hqnSWA8=; b=TEqAgS/hsApCNwl+CHO+6SoIkPpK4yadlxMSKbvnsWr5u+1VXOr
        ymFIk6PgOMjbnMFJ3+L91utl1WBhUhJ626wWWPVzMBequEDL22TvFlB3fQUEBVYd
        gsjbE6gE3kUNNAF9560R4uvZ9N/VKc17841muTB6cF+jJ11N3iokeL2egcbzFur6
        Kx3Blsu89K3oR4EX99B7TuOASebdKyVWyachP9ZeMyX669Dw2qh7yUWudFGYubKt
        02LA9LglJLXCDRh84iyTD2oYZ5V5t+5YOrjL91fHypjuSnwmGWbuGvoOuvds8xBb
        0+jN4VI+kTjLgQD+G1YoPQX/2p8i9nTeP2Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3JP3jf5WO2TC for <linux-kernel@vger.kernel.org>;
        Wed, 15 Jun 2022 17:23:31 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNjZT1QXqz1Rvlc;
        Wed, 15 Jun 2022 17:23:29 -0700 (PDT)
Message-ID: <0dcebae2-5e4e-a0d3-181d-37bb9b40d564@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 09:23:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 07/23] ata: libahci_platform: Convert to using devm
 bulk clocks API
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-8-Sergey.Semin@baikalelectronics.ru>
 <3bf20887-6e2f-41f4-e4ec-5c2278f6cb18@opensource.wdc.com>
 <20220615204509.siz54h4vbgvb3zkm@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615204509.siz54h4vbgvb3zkm@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/06/16 5:45, Serge Semin wrote:
[...]
>>> +		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
>>> +		if (!hpriv->clks) {
>>> +			rc = -ENOMEM;
>>> +			goto err_out;
>>> +		}
>>> +		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
> 
>>> +		if (IS_ERR(hpriv->clks->clk)) {
>>> +			rc = PTR_ERR(hpriv->clks->clk);
>>> +			goto err_out;
>>> +		} else if (hpriv->clks->clk) {
>>
>> Nit: the else is not needed here.
> 
> Well, it depends on what you see behind it. I see many reasons to keep
> it and only one tiny reason to drop it. Keeping it will improve the
> code readability and maintainability like having a more natural
> execution flow representation, thus clearer read-flow (else part as
> exception to the if part), less modifications should the goto part is
> changed/removed, a more exact program flow representation can be used
> by the compiler for some internal optimizations, it's one line shorter
> than the case we no 'else' here. On the other hand indeed we can drop
> it since if the conditional statement is true, the code afterwards
> won't be executed due to the goto operator. But as I see it dropping
> the else operator won't improve anything, but vise-versa will worsen
> the code instead. So if I get to miss something please justify why you
> want it being dropped, otherwise I would rather preserve it.

An else after a goto or return is never necessary and in my opinion makes the
code harder to read. I am not interested in debating this in general anyway. For
this particular case, the code would be:

		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
		if (IS_ERR(hpriv->clks->clk)) {
			/* Error path */
			rc = PTR_ERR(hpriv->clks->clk);
			goto err_out;
		}

		/* Normal path */
		if (hpriv->clks->clk) {
			...
		}

Which in my opinion is a lot easier to understand compared to having to parse
the if/else if and figure out which case in that sequence is normal vs error.

As noted, this is a nit. If you really insist, keep that else if.

> 
> -Sergey
> 
>>
>>> +			hpriv->clks->id = __clk_get_name(hpriv->clks->clk);
>>> +			hpriv->n_clks = 1;
>>>  		}
>>> -		hpriv->clks[i] = clk;
>>>  	}
>>>  
>>>  	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
