Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF652E4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbiETGUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiETGUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:20:03 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF7F14C74D;
        Thu, 19 May 2022 23:20:00 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JJnLmo022160;
        Fri, 20 May 2022 08:19:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=efeJifdma56rD3trwjzxCU9cZ0DK0SMJX02sClHrbfw=;
 b=duJP13Um8k8SytXA95+J6+41SUITXlFftu0VVJusXjoXGlWE+hO9McLhFxdnCVLFtko1
 ZmSdCQpkEndPusIF/r9q5pcVDvxYw/w4vA2uL/mDMWuAE/RyTisKju+kfTIxG/5rT75w
 sf2k1ODFUeXbP3rmTs5q2suSUrnh5Zi4ZauLVONb3/P8W/k3AVM8sS7/R/C6/sEKEc6/
 +x50g20BkAv+OK8L5ktVfvxs0SiDpsdA+krPtVMSDNX2Kn7RBdZ7LbEnPkGKMwRiUGjk
 v7bBF8qzczUzLu9zTPVm9QNOMIqopusYnZrRV1If34WISsbNJAAEHRn2BF5iqXkCC+Kk nA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23aj62rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 08:19:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 619B410002A;
        Fri, 20 May 2022 08:19:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 58640210F73;
        Fri, 20 May 2022 08:19:37 +0200 (CEST)
Received: from [10.201.20.162] (10.75.127.49) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 20 May
 2022 08:19:36 +0200
Message-ID: <6f3de705-7db5-584c-1b3a-3ff7fb5c9096@foss.st.com>
Date:   Fri, 20 May 2022 08:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 7/9] serial: st-asc: Sanitize CSIZE and correct PARENB
 for CS7
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220519081808.3776-1-ilpo.jarvinen@linux.intel.com>
 <20220519081808.3776-8-ilpo.jarvinen@linux.intel.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220519081808.3776-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_02,2022-05-19_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo

On 5/19/22 10:18, Ilpo Järvinen wrote:
> Only CS7 and CS8 seem supported but CSIZE is not sanitized from CS5 or
> CS6 to CS8. In addition, ASC_CTL_MODE_7BIT_PAR suggests that CS7 has
> to have parity, thus add PARENB.
> 
> Incorrect CSIZE results in miscalculation of the frame bits in
> tty_get_char_size() or in its predecessor where the roughly the same
> code is directly within uart_update_timeout().
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> Fixes: c4b058560762 (serial:st-asc: Add ST ASC driver.)
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/st-asc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index d7fd692286cf..1b0da603ab54 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -535,10 +535,14 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
>  	/* set character length */
>  	if ((cflag & CSIZE) == CS7) {
>  		ctrl_val |= ASC_CTL_MODE_7BIT_PAR;
> +		cflag |= PARENB;
>  	} else {
>  		ctrl_val |= (cflag & PARENB) ?  ASC_CTL_MODE_8BIT_PAR :
>  						ASC_CTL_MODE_8BIT;
> +		cflag &= ~CSIZE;
> +		cflag |= CS8;
>  	}
> +	termios->c_cflag = cflag;
>  
>  	/* set stop bit */
>  	ctrl_val |= (cflag & CSTOPB) ? ASC_CTL_STOP_2BIT : ASC_CTL_STOP_1BIT;

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
