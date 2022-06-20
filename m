Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1354655241F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbiFTSi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244951AbiFTSiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:38:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDD91FA5B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99814B815BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9938C341C4;
        Mon, 20 Jun 2022 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655750332;
        bh=vNOdTxFl7DnYGxX/d6WaJbW/BHTUwXFeTykcPJcjGP8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aHoI9XLQha3uF915u/2ze7C9a9I3QemQ46WczQ3CP7PvySISyHy5BcMJt21+aPeS9
         tJKjgs4lpGS6bHbu8SytAmGh+RVf3f9uU/wLSihwmVFUmwKGkRJE6y2sVAWw+36V5l
         ZtMKU5S8/Ewk24yY4JSsFxz9IyI1akkTDQD648N/Pt6+F+t8noAsJNNpysZnyrqqx7
         4H1y+ip4v3WOn7SCJ+e6oPHYMZrbX4dAVozoafHv6pqUOHMc1sbXQHIZ+texBMbCPd
         rnFRNsJ6nAm7Si565/WK8Dn/U5DbQA6udbbstqc8eogy+46imZjYxSiBr3CPiFGub1
         qJlNaCpcGsHHg==
Message-ID: <e5501570657870e3cdbbce591b0def973f5a20b6.camel@kernel.org>
Subject: Re: [PATCH v4 1/3] tracing: eprobe: remove duplicate is_good_name()
 operation
From:   Tom Zanussi <zanussi@kernel.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 20 Jun 2022 13:38:50 -0500
In-Reply-To: <d14f0409-351f-873e-b7ca-82ff444bf809@quicinc.com>
References: <1654171861-24014-1-git-send-email-quic_linyyuan@quicinc.com>
         <1654171861-24014-2-git-send-email-quic_linyyuan@quicinc.com>
         <9a7e0b6087540c9f868d60cbfc88ccefa8070a1b.camel@kernel.org>
         <d14f0409-351f-873e-b7ca-82ff444bf809@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGlueXUsCgpPbiBUdWUsIDIwMjItMDYtMTQgYXQgMDg6NDggKzA4MDAsIExpbnl1IFl1YW4g
d3JvdGU6Cj4gaGkgVG9tLAo+IAo+IE9uIDYvMTQvMjAyMiA1OjAxIEFNLCBUb20gWmFudXNzaSB3
cm90ZToKPiA+IEhpIExpbmh1LAo+ID4gCj4gPiBPbiBUaHUsIDIwMjItMDYtMDIgYXQgMjA6MTAg
KzA4MDAsIExpbnl1IFl1YW4gd3JvdGU6Cj4gPiA+IHRyYWNlcHJvYmVfcGFyc2VfZXZlbnRfbmFt
ZSgpIGFscmVhZHkgdmFsaWRhdGUgZ3JvdXAgYW5kIGV2ZW50Cj4gPiA+IG5hbWUsCj4gPiA+IHRo
ZXJlIGlzIG5vIG5lZWQgdG8gY2FsbCBpc19nb29kX25hbWUoKSBhZnRlciBpdC4KPiA+ID4gCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IExpbnl1IFl1YW4gPHF1aWNfbGlueXl1YW5AcXVpY2luYy5jb20+
Cj4gPiA+IC0tLQo+ID4gPiB2MjogZHJvcCB2MSBjaGFuZ2UgYXMgaXQgaXMgTkFDSy4KPiA+ID4g
wqDCoMKgwqAgYWRkIGl0IHRvIHJlbW92ZSBkdXBsaWNhdGUgaXNfZ29vZF9uYW1lKCkuCj4gPiA+
IHYzOiBtb3ZlIGl0IGFzIGZpcnN0IHBhdGNoLgo+ID4gPiB2NDogbm8gY2hhbmdlCj4gPiA+IAo+
ID4gPiDCoMKga2VybmVsL3RyYWNlL3RyYWNlX2Vwcm9iZS5jIHwgNCAtLS0tCj4gPiA+IMKgwqAx
IGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9r
ZXJuZWwvdHJhY2UvdHJhY2VfZXByb2JlLmMKPiA+ID4gYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXBy
b2JlLmMKPiA+ID4gaW5kZXggN2Q0NDc4NS4uMTdkNjRlMyAxMDA2NDQKPiA+ID4gLS0tIGEva2Vy
bmVsL3RyYWNlL3RyYWNlX2Vwcm9iZS5jCj4gPiA+ICsrKyBiL2tlcm5lbC90cmFjZS90cmFjZV9l
cHJvYmUuYwo+ID4gPiBAQCAtODc4LDE2ICs4NzgsMTIgQEAgc3RhdGljIGludCBfX3RyYWNlX2Vw
cm9iZV9jcmVhdGUoaW50IGFyZ2MsCj4gPiA+IGNvbnN0IGNoYXIgKmFyZ3ZbXSkKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNhbml0aXplX2V2ZW50X25hbWUoYnVmMSk7
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBldmVudCA9IGJ1ZjE7Cj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKCFpc19nb29k
X25hbWUoZXZlbnQpIHx8ICFpc19nb29kX25hbWUoZ3JvdXApKQo+ID4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZ290byBwYXJzZV9lcnJvcjsKPiA+IHRyYWNlcHJvYmVfcGFyc2Vf
ZXZlbnRfbmFtZSgpIGlzIG9ubHkgY2FsbGVkIGlmIChldmVudCkuwqAgSW4gdGhlCj4gPiAhZXZl
bnTCoGNhc2UsIHdvdWxkbid0IHRoZSBpc19nb29kX25hbWUoKSBjaGVja3Mgc3RpbGwgYmUgbmVl
ZGVkCj4gPiAoc2luY2UKPiA+IGluIHRoYXQgY2FzZSBidWYxIGlzIGFzc2lnbmVkIHRvIGV2ZW50
KT8KPiAKPiB3aGVuIHVzZXIgaW5wdXQgbm/CoCBldmVudCBuYW1lLCBpdCB3aWxsIGdlbmVyYXRl
IGV2ZW50IG5hbWUgZnJvbQo+IHNlY29uZMKgIAo+IFNZU1RFTS5FVkVOVCwKPiAKPiBhbmQgaXQg
d2lsbCB2YWxpZGF0ZSB3aXRoIGZvbGxvd2luZyB0cmFjZXByb2JlX3BhcnNlX2V2ZW50X25hbWUo
KS4KPiAKPiAKClJpZ2h0LCBidXQgdGhhdCBoYXBwZW5zIGluIHlvdXIgc2Vjb25kIHBhdGNoICdb
UEFUQ0ggdjUgMi8zXSB0cmFjaW5nOgphdXRvIGdlbmVyYXRlIGV2ZW50IG5hbWUgd2hlbiBjcmVh
dGUgYSBncm91cCBvZiBldmVudHMnLCBub3QgdGhpcyBvbmUuCsKgClNvIGlmIHlvdSBhcHBseSBv
bmx5IHRoaXMgcGF0Y2gsIHRoZSAhZXZlbnQgY2FzZSB3aWxsIGFzc2lnbiBldmVudCBidXQKaXQg
d2lsbCByZW1haW4gdW5jaGVja2VkIHdoZW4gdXNlZCBsYXRlciBpbiB0aGlzIGZ1bmN0aW9uLgoK
SXQgd291bGQgbWFrZSBtb3JlIHNlbnNlIHRvIHJlbW92ZSB0aGlzIGNoZWNrIGluIHBhdGNoIDIv
MyBhbG9uZyB3aXRoCnRoZSBjb2RlIHRoYXQgZG9lcyB0aGUgZ2VuZXJhdGluZy4uLgoKPiAoCj4g
Cj4gaWYgeW91IGFncmVlLCBpIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIHRvIHVwZGF0ZSBhIG1p
bm9yIGlzc3VlIGluIAo+IHNlY29uZCBwYXRjaCwKPiAKPiAKPiDCoMKgwqDCoMKgwqDCoMKgIHN5
c19ldmVudCA9IGFyZ3ZbMV07Cj4gLcKgwqDCoMKgwqDCoCByZXQgPSB0cmFjZXByb2JlX3BhcnNl
X2V2ZW50X25hbWUoJnN5c19ldmVudCwgJnN5c19uYW1lLAo+IGJ1ZjIsCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN5c19ldmVudCAtIGFyZ3ZbMV0pOwo+IC3CoMKgwqDCoMKgwqAgaWYgKHJl
dCB8fCAhc3lzX25hbWUpCj4gK8KgwqDCoMKgwqDCoCByZXQgPSB0cmFjZXByb2JlX3BhcnNlX2V2
ZW50X25hbWUoJnN5c19ldmVudCwgJnN5c19uYW1lLAo+IGJ1ZjIsIDApOwo+ICvCoMKgwqDCoMKg
wqAgaWYgKCFzeXNfZXZlbnQgfHwgIXN5c19uYW1lKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdvdG8gcGFyc2VfZXJyb3I7Cj4gCj4gKQo+IAo+ID4gCj4gPiA+IMKgIAo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqBzeXNfZXZlbnQgPSBhcmd2WzFdOwo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqByZXQgPSB0cmFjZXByb2JlX3BhcnNlX2V2ZW50X25hbWUoJnN5c19ldmVudCwgJnN5
c19uYW1lLAo+ID4gPiBidWYyLAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3lz
X2V2ZW50IC0gYXJndlsxXSk7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQgfHwgIXN5
c19uYW1lKQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBwYXJz
ZV9lcnJvcjsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKCFpc19nb29kX25hbWUoc3lzX2V2ZW50
KSB8fCAhaXNfZ29vZF9uYW1lKHN5c19uYW1lKSkKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGdvdG8gcGFyc2VfZXJyb3I7Cj4gPiBJIGFncmVlIHRoaXMgb25lIGlzbid0IG5l
ZWRlZC4KCkJ1dCBrZWVwIHRoaXMgb25lIGluIHRoaXMgcGF0Y2gsIHNpbmNlIGl0J3MgdXNlZnVs
IG9uIGl0cyBvd24gYXMgYQpzdGFuZGFsb25lIGNsZWFudXAgcmVnYXJkbGVzcyBvZiB3aGV0aGVy
IG9yIG5vdCBwYXRjaCAyLzMgZ2V0cyBtZXJnZWQuCgpUb20KCj4gPiBUaGFua3MsCj4gPiAKPiA+
IFRvbQo+ID4gCj4gPiA+IMKgIAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZl
dmVudF9tdXRleCk7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoGV2ZW50X2NhbGwgPSBmaW5kX2Fu
ZF9nZXRfZXZlbnQoc3lzX25hbWUsIHN5c19ldmVudCk7Cgo=

