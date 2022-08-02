Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE458791E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiHBIgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiHBIgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:36:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C86BF43;
        Tue,  2 Aug 2022 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659429331;
        bh=iIYXOeF3+KaJ7IbFEL8mFs74uWBNxD2A1YQSgpC/z8o=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SYEej6jMKWGnTCirupgWqUuYA7cFbocaY0g/J0oh9c2q+DlGLqJJCv9jgCrjBxvR7
         dfqqttb66pIhq+Hd9wA/B4r3Pi04DnIOADOe2Z65z3OXYfxIMjJ51DqL3RN1ORP1hZ
         jUX536/oK10qjdJoN6Uo4hwLRPFpkskz1he/jaB8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.166.88]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1nnLEj1NPy-00hc2r; Tue, 02
 Aug 2022 10:35:31 +0200
Message-ID: <16dfaab2-bce5-6f07-7c18-d568f4719d75@gmx.de>
Date:   Tue, 2 Aug 2022 10:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Input: check the return value of ioremap() in
 gscps2_probe()
Content-Language: en-US
To:     studentxswpy@163.com, James.Bottomley@HansenPartnership.com,
        dmitry.torokhov@gmail.com, linux-parisc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hacash Robot <hacashRobot@santino.com>
References: <20220802072033.3211980-1-studentxswpy@163.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220802072033.3211980-1-studentxswpy@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jmwb6AnzQ+6m9q1J6y/EkOGl4AmWemJ/9d1eOhtb8NIS0nKGBIE
 Ou+yg5arQBDV2IRe1EL8CUn/XAyv9MfjI2x80Ll3TqTS4hvPyLw79oiPtma+ii1w+cgVa1w
 +crCHwsFROsR1iv1+e3D3JftDfdpDomkGuCB91b20n1Db4MIywvQFPiAYZhewgH2gYKpG5b
 /ksCrfmQabaXngLDIV9VA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wt2UlAJTeOM=:A/aJZ/ayLUu0oGpwIN4x+g
 A3Qz8f4MCASFyOuKcR8hMdHfM8vk9s05OjrHxlReLkShm8vEQugqooKYkvVmK66uA61o2kuv1
 ETbutf8VHHPOpaP0I+4P3BQYMuZmJuW9PD3vYLPNafJvPFyi1uFoFJ2TZ4vx5bfGl1Hi+1cY3
 EAHutgwGAz/zcybE+Swq0CyQ/5QRdGnbC5/4fyGtuBCxkc9gMLtkUhTfA0wn9VTKnJzck4XD9
 DIqhk8faETRfaTxvLMumHyPAZAx6GIwY2c1/RnrKR+5LHN/vo44HyHykuQfQH40zsO4a2lKeN
 HdQLi1WU92TS7azRs5dRTZb3V71Evyg78baSL3yKhIcY0RAgkSB6NSP57hhr5Ta5mJMdsZvmO
 DbWss17/ZMra8rgwAxWsChsgB3fnS4MkQLlhn1n58nDSyTLCsRoFzBYQhL20pl4wIUy4ScqQC
 pZGj0clzK8ydEh29JsySz8+VGxDT3lpOP82Y4iRM9erus6xNFS9wBl7z5X/k0ljW4Lvn8v1vj
 6Spjtt0YHeLrMMdbOz79xrQ6jM9uyGzXXfNthFVbwSr8PdhmfF2S1RH7c/9wgW0NIxh2k5CQB
 QsXtCnbl1H1iA1YWSZRyejp48iaDEPAhxlmCFhu849PJdHwVb71zeiiDfDc3+02z2ZccjIrsm
 PR8RYDz4/6Gb4v24X8nQyhLoViJEwBK5oc8zcaueBghfNBJ1/doZ5YxqFD8QM1xJxhciFIFP9
 Xvyj6Pd//qmJsHNnJH47j53O5pRZRwPP1Lsk9lZ8DugZg2qeNs5uaVa3Rq0YynwMbsXEIuVNh
 IUvOKQJ8U3BUx8b/QGjEhgUX8K7o+T+w/6JJukkA21oSV9eCOBe1dffbEss5a4IbYpOkWVUzP
 qKPU+yhff7zfNO54AZY7NdKuSo6BklmAfNZpKXQslF/1z5PPH8JwG9ZR0E9e+O+yewImk13sQ
 tkNRyRrF7zpEWmL2fOWiQ8GVNTZOZHuEZ6A49F7gnFHGM4AhRteB+hWJXm6L9Bd5gaCjSys3k
 y1aIXTwtyR6YhqWb3ypqOgT/9V5ipLWWBQfp64Y4HqexJh/UVeCtdKRvCOz3DTTrDxA4Ow1Rp
 uAAqv5PgD1yFpfkQAv/m5h+D+KIf9GA1ViF
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 09:20, studentxswpy@163.com wrote:
> From: Xie Shaowen <studentxswpy@163.com>
>
> The function ioremap() in gscps2_probe() can fail, so
> its return value should be checked.
>
> Fixes: 4bdc0d676a643 ("remove ioremap_nocache and devm_ioremap_nocache")
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: Xie Shaowen <studentxswpy@163.com>

I've applied it to the parisc git tree.

Thanks!
Helge

> ---
>  drivers/input/serio/gscps2.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index a9065c6ab550..da2c67cb8642 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c
> @@ -350,6 +350,10 @@ static int __init gscps2_probe(struct parisc_device=
 *dev)
>  	ps2port->port =3D serio;
>  	ps2port->padev =3D dev;
>  	ps2port->addr =3D ioremap(hpa, GSC_STATUS + 4);
> +	if (!ps2port->addr) {
> +		ret =3D -ENOMEM;
> +		goto fail_nomem;
> +	}
>  	spin_lock_init(&ps2port->lock);
>
>  	gscps2_reset(ps2port);

