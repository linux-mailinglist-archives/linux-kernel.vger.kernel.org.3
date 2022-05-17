Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08BE529B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbiEQHod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiEQHoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:44:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8271C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:44:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so856959wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=GeBUOwMtlUJXTRUysICohEtNecUKuIK32F5RW3LBD8E=;
        b=jSQfurSZoLCu/ecIEGtXRqUJGG5lmXEBzgxp0yfX0Ju3dv9SdPy8huwCsGTpcR2j3v
         0HS99sC1AT8P/NBTJot2xMttBWZa/MQeulNwQpTjVZuiMA6YdGvxK/ilct6nTGrW95Pz
         8OGUNKQK0lrQXAV+X5zzQL4otZeK915ASp+WEjGOcl17I43nxtEImhDiIr3peaKuT/MK
         zKlpMhXoMk6xWNDfnh0yG9yPVqLlVZcqTh4cDCtAXW3eJWkQZvng4m61AoJj0SmyDyIJ
         gZlKOBUBtOCdN/WsTvxgdJoD33d+/krusMFpWqlZi7SC1Gf02n1CFlXN6y8Stc5qHFpD
         C2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=GeBUOwMtlUJXTRUysICohEtNecUKuIK32F5RW3LBD8E=;
        b=ubKB+B92JRN7FLuivRP5s/b4hjy1xnp7agOgVmD0/R5GoZuzfL7+1Yfo3VHuzL+ofQ
         R8XYcm5x1DCOGtl5tKhjz7oe5lcoOKYJ8uW7cd76ZIIrrggt2xtFFDKTwcnS9KK8alPP
         /DGjq9vorUMdV7mz6cBaxjmN8v+alUnk6QBCjmDF9IE/xd7nug+hbc98xBijG8Nvx/1S
         yl1mzWsRQK80TedpPYHlb3ecNToa0bBN/pZ5satRshPbyQhkG7EazDJ2v1tkfkDFpzYO
         cdQylDybQ+Wqoys3DUEdDnoWimTpmONpTqEpeaDSxOHeYUhbaDfmGXKf3/MGvKcW1Ynu
         3BvQ==
X-Gm-Message-State: AOAM531azvcalwNaeZtyZCLdtHAOrSIvSbRCtJsHcfyyr0mxrcb8ONLJ
        xhZ1yzeXpdMoQERQCB7QwvMLIMENbQqwMQ==
X-Google-Smtp-Source: ABdhPJw6WRmdGTZdQGzE0o3kXC0cOK9cKdioBhbLksj2XIDveW94c6axpGgQVquU/0ojwo7V+rYo6g==
X-Received: by 2002:a05:600c:1d17:b0:394:646d:fd73 with SMTP id l23-20020a05600c1d1700b00394646dfd73mr30224003wms.103.1652773468281;
        Tue, 17 May 2022 00:44:28 -0700 (PDT)
Received: from giga-mm.localdomain ([195.245.23.54])
        by smtp.gmail.com with ESMTPSA id bg31-20020a05600c3c9f00b003942a244ed7sm1182942wmb.28.2022.05.17.00.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 00:44:27 -0700 (PDT)
Message-ID: <c80f2441c19766ef13a44c5cd62ec5af6a1e4af3.camel@gmail.com>
Subject: Re: [PATCH v2] ep93xx: clock: Do not return the address of the
 freed memory
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Genjian Zhang <zhanggenjian123@gmail.com>,
        hsweeten@visionengravers.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>
Date:   Tue, 17 May 2022 09:44:26 +0200
In-Reply-To: <20220517073946.1339333-1-zhanggenjian@kylinos.cn>
References: <20220517073946.1339333-1-zhanggenjian@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IEdlbmppYW4hCgpPbiBUdWUsIDIwMjItMDUtMTcgYXQgMTU6MzkgKzA4MDAsIEdl
bmppYW4gWmhhbmcgd3JvdGU6Cj4gQXZvaWQgcmV0dXJuIGZyZWVkIG1lbW9yeSBhZGRyZXNzZXMs
TW9kaWZpZWQgdG8gdGhlIGFjdHVhbCBlcnJvcgo+IHJldHVybiB2YWx1ZSBvZiBjbGtfcmVnaXN0
ZXIoKS4KPiAKPiBGaXhlczogOTY0NWNjYzdiZDdhICgiZXA5M3h4OiBjbG9jazogY29udmVydCBp
bi1wbGFjZSB0byBDT01NT05fQ0xLIikKPiBTaWduZWQtb2ZmLWJ5OiBHZW5qaWFuIFpoYW5nIDx6
aGFuZ2dlbmppYW5Aa3lsaW5vcy5jbj4KCkFja2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFs
ZXhhbmRlci5zdmVyZGxpbkBnbWFpbC5jb20+Cgo+IC0tLQo+IMKgYXJjaC9hcm0vbWFjaC1lcDkz
eHgvY2xvY2suYyB8IDEwICsrKysrKy0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtZXA5
M3h4L2Nsb2NrLmMgYi9hcmNoL2FybS9tYWNoLWVwOTN4eC9jbG9jay5jCj4gaW5kZXggNGZhNmVh
NTQ2MWI3Li44NWE0OTZkZGM2MTkgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1lcDkzeHgv
Y2xvY2suYwo+ICsrKyBiL2FyY2gvYXJtL21hY2gtZXA5M3h4L2Nsb2NrLmMKPiBAQCAtMzQ1LDkg
KzM0NSwxMCBAQCBzdGF0aWMgc3RydWN0IGNsa19odyAqY2xrX2h3X3JlZ2lzdGVyX2RkaXYoY29u
c3QgY2hhciAqbmFtZSwKPiDCoMKgwqDCoMKgwqDCoMKgcHNjLT5ody5pbml0ID0gJmluaXQ7Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgY2xrID0gY2xrX3JlZ2lzdGVyKE5VTEwsICZwc2MtPmh3KTsK
PiAtwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKGNsaykpCj4gK8KgwqDCoMKgwqDCoMKgaWYgKElT
X0VSUihjbGspKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBrZnJlZShwc2Mp
Owo+IC0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9DQVNUKGNs
ayk7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gJnBzYy0+aHc7
Cj4gwqB9Cj4gwqAKPiBAQCAtNDUyLDkgKzQ1MywxMCBAQCBzdGF0aWMgc3RydWN0IGNsa19odyAq
Y2xrX2h3X3JlZ2lzdGVyX2Rpdihjb25zdCBjaGFyICpuYW1lLAo+IMKgwqDCoMKgwqDCoMKgwqBw
c2MtPmh3LmluaXQgPSAmaW5pdDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBjbGsgPSBjbGtfcmVn
aXN0ZXIoTlVMTCwgJnBzYy0+aHcpOwo+IC3CoMKgwqDCoMKgwqDCoGlmIChJU19FUlIoY2xrKSkK
PiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKGNsaykpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGtmcmVlKHBzYyk7Cj4gLQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gRVJSX0NBU1QoY2xrKTsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAmcHNjLT5odzsKPiDCoH0KPiDCoAoKLS0gCkFsZXhhbmRlciBTdmVyZGxp
bi4KCg==

