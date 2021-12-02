Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892704664A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhLBNpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:45:53 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.170]:54201 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358327AbhLBNps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:45:48 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2021 08:45:47 EST
X-KPN-MessageId: 9011b093-5375-11ec-8a6e-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 9011b093-5375-11ec-8a6e-005056ab378f;
        Thu, 02 Dec 2021 14:41:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:mime-version:date:message-id:from:to:subject;
        bh=s/xVqNVOlwQge/G2W/Pt+qdPvzezn4iibA3pPzJ8pns=;
        b=Wpj9W31xUSyCjSI/ALBRXxRks0yuXGnsi803+cC9/pM0rTioNUa6PTLbxYwBDMpH7xMnsMmAg3FLR
         jyO4Pi5Gf9mvQx3Gsd/S+lbHKTFIXfPBQzWaCtfe69O58QtmI/Xaa2wP43JHQX8zsoGZkN0FPMSNCW
         l1m/p2gBNqEnGCbaGTuT9sHLLtN7hImIPWHDlkzicTKFJkD/eFTWF6/A8GXtcmknCCUu6T2SMRDyhp
         Bj5YsahnuDP3TXFZo3IDjQsljWF91YxFEMR005cb1QCuU6ZWLc2nfc6EQGWYWdLCNbFsrfNJKH9YwG
         Kedlurco/nSsSeP1LOxoD8yotfrb56Q==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|LFJL3ISlOVsPjOchdIcRHzGsAB/c7qkOye+aaa47FBeyZUvDXkjIVc2N0FQyWXR
 njJy62WTQGDOdwahA6A9MRg==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id abae1dc3-5375-11ec-81f5-005056ab7447;
        Thu, 02 Dec 2021 14:42:20 +0100 (CET)
Subject: Re: [PATCH] media: vidtv: Fix a wild pointer dereference in
 vidtv_channel_pmt_match_sections()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211130163946.189005-1-zhou1615@umn.edu>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <94dbfe62-43b3-a293-5f59-d8bd1f35bde1@xs4all.nl>
Date:   Thu, 2 Dec 2021 14:42:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130163946.189005-1-zhou1615@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2021 17:39, Zhou Qingyang wrote:
> In vidtv_channel_pmt_match_sections(), vidtv_psi_pmt_stream_init() is
> assigned to tail and &tail->descriptor is used in
> vidtv_psi_desc_assign(). There is a dereference of &tail->descriptor
> in vidtv_psi_desc_assign(), which could lead to a wild pointer
> dereference onfailure of vidtv_psi_pmt_stream_init().

onfailure -> on failure

> 
> Fix this bug by adding a check of tail.
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Builds with CONFIG_DVB_VIDTV=m show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: f90cf6079bf6 ("media: vidtv: add a bridge driver")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>  drivers/media/test-drivers/vidtv/vidtv_channel.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/media/test-drivers/vidtv/vidtv_channel.c b/drivers/media/test-drivers/vidtv/vidtv_channel.c
> index 7838e6272712..f2faa5504642 100644
> --- a/drivers/media/test-drivers/vidtv/vidtv_channel.c
> +++ b/drivers/media/test-drivers/vidtv/vidtv_channel.c
> @@ -318,6 +318,10 @@ vidtv_channel_pmt_match_sections(struct vidtv_channel *channels,
>  	struct vidtv_psi_table_pmt_stream *s = NULL;
>  	struct vidtv_channel *cur_chnl = channels;
>  	struct vidtv_psi_desc *desc = NULL;
> +	struct vidtv_mux *m = container_of(&channels,
> +					struct vidtv_mux,
> +					channels);
> +
>  	u16 e_pid; /* elementary stream pid */
>  	u16 curr_id;
>  	u32 j;
> @@ -341,6 +345,13 @@ vidtv_channel_pmt_match_sections(struct vidtv_channel *channels,
>  					tail = vidtv_psi_pmt_stream_init(tail,
>  									 s->type,
>  									 e_pid);
> +
> +					if (!tail) {
> +						vidtv_psi_pmt_stream_destroy(head);

I honestly can't tell if this is the right thing to do.

Daniel, can you take a look at this?

> +						dev_warn_ratelimited(m->dev,
> +							"No enough memory for vidtv_psi_pmt_stream_init");

No -> Not
Add newline at the end of the string.

> +						return;
> +					}
> 
>  					if (!head)
>  						head = tail;
> 

Regards,

	Hans
